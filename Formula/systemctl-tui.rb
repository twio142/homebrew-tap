class SystemctlTui < Formula
  desc "Fast, simple TUI for interacting with systemd services and their logs"
  homepage "https://github.com/rgwood/systemctl-tui"
  url "https://github.com/rgwood/systemctl-tui/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "279daea0c3664087f45763d347544f92117b821cbeef01aef4f02e21b4f11ceb"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/systemctl-tui-v0.6.0"
    sha256 cellar: :any, x86_64_linux: "ef05a813b6a8bb5b794967939d4a0b2536c6d0827f1d3d04bb56147b8dc581d2"
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
