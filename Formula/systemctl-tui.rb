class SystemctlTui < Formula
  desc "Fast, simple TUI for interacting with systemd services and their logs"
  homepage "https://github.com/rgwood/systemctl-tui"
  url "https://github.com/rgwood/systemctl-tui/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "7ce318bb5f9fa4fc4b266557d1476bd8ed058faa15807a579090bd93e994ab23"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/systemctl-tui-v0.6.1"
    sha256 cellar: :any, x86_64_linux: "d5b7e95443021edaaf97c32ae6108eb86acddc79bd1aa10917f6f2d31f9eba5d"
  end

  depends_on "rust" => :build
  depends_on :linux

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"systemctl-tui", "--version"
  end
end
