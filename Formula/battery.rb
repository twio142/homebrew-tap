class Battery < Formula
  desc "CLI tool for managing battery charging"
  homepage "https://github.com/actuallymentor/battery"
  url "https://github.com/actuallymentor/battery/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "67fedb7da88e5d59994ae617643029145a26ab36ccb45af2fc3b0588ee33403e"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/battery-v1.2.3"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "225313f50fd55290c9f3952d8b04913d050cfece2817f1f0510e3915bbb2fdcd"
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
