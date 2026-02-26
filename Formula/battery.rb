class Battery < Formula
  desc "CLI tool for managing battery charging"
  homepage "https://github.com/actuallymentor/battery"
  url "https://github.com/actuallymentor/battery/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "37ffc32d647a5ec20af2ddabb04eba748bc2b29b12e469ccefdd182db72dce7a"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/battery-v1.3.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b0d1e73a87ba561ce32e34aedeabfcbd9d0ca09023ee22c8bac6a44c47a43598"
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
      s.gsub!(/^binfolder=.*/, "binfolder=#{opt_bin}")
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
