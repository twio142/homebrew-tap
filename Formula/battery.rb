class Battery < Formula
  desc "CLI tool for managing battery charging"
  homepage "https://github.com/actuallymentor/battery"
  url "https://github.com/actuallymentor/battery/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "1b10b42f6b010d99c9e4d46846ee79f113367bb49b940b43f10312273cdbbdcb"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/battery-v1.3.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2b27ea88ab7c35c758fff0469b09dc722e412c113a0e28dd3e5b317fd8c867ad"
  end

  depends_on "make" => :build

  resource "smc" do
    url "https://github.com/hholtmann/smcFanControl.git",
        revision: "e1bd672bcd2d72eddff9b6da7b9cae38e35c4206"
  end

  def install
    resource("smc").stage do
      cd "smc-command" do
        system "make"
        bin.install "smc"
      end
    end

    inreplace "battery.sh" do |s|
      s.gsub! "binfolder=/usr/local/bin", "binfolder=#{opt_bin}"
      s.gsub! "configfolder=$HOME/.battery", "configfolder=$HOME/.config/battery"
    end

    bin.install "battery.sh" => "battery"
  end

  def caveats
    <<~EOS
      To allow 'battery' to access the SMC without a password, you need to grant it permissions manually.
      Please run the following command in your terminal:

        sudo #{opt_bin}/battery visudo $(whoami)

      This command will securely edit your sudoers file to add a NOPASSWD rule for the smc binary.
    EOS
  end

  test do
    assert_match "Battery CLI utility", shell_output(bin/"battery")
  end

  service do
    run [opt_bin/"battery", "maintain_synchronous", "recover"]
    keep_alive true
    run_at_load true
    log_path var/"log/battery.log"
    error_log_path var/"log/battery.log"
  end
end
