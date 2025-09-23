class Ttyper < Formula
  desc "Terminal-based typing test"
  homepage "https://github.com/max-niederman/ttyper"
  url "https://github.com/max-niederman/ttyper/archive/refs/tags/v1.6.0.tar.gz" # url
  sha256 "f7e4ff2f803483b17f35aa0c02977326a0546a95f5b465b4dd34ff17e45b4021" # sha256
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/max-niederman/ttyper/releases/download/v1.6.0/ttyper-aarch64-apple-darwin.tar.gz" # arm_macos_url
      sha256 "76dabc64a5b38fb4379db3104431c748f1be0b2ccb3319d2ec464d3a266b6a3e" # arm_macos_sha256
    else
      url "https://github.com/max-niederman/ttyper/releases/download/v1.6.0/ttyper-x86_64-apple-darwin.tar.gz" # intel_macos_url
      sha256 "837236926baa343f8d732e29f9880c89ebf0d8355f93b0821623a35dc71fbee0" # intel_macos_sha256
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/max-niederman/ttyper/releases/download/v1.6.0/ttyper-x86_64-unknown-linux-gnu.tar.gz" # linux_url
      sha256 "b41549968a8f08f93cdc05698402a8055507801e2363a1792aaef8a9f1081ffd" # linux_sha256
    end
  end

  def install
    bin.install "ttyper"
  end

  test do
    system bin/"ttyper", "--version"
  end
end
