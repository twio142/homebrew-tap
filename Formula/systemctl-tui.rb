class SystemctlTui < Formula
  desc "Fast, simple TUI for interacting with systemd services and their logs"
  homepage "https://github.com/rgwood/systemctl-tui"
  url "https://github.com/rgwood/systemctl-tui/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "004e160f4f59f824ac35baf23fbc615b9f12bdb4f5eee122017bfe24a6ec02d9"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/systemctl-tui-v0.8.0"
    sha256 cellar: :any, x86_64_linux: "68c8c1e5ba6f4626d502803cfdbe2d0e2a71f8a17aed1c8545ae4bceeeee52a9"
  end

  depends_on "rust" => :build
  depends_on :linux

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/systemctl-tui")
  end

  test do
    system bin/"systemctl-tui", "--version"
  end
end
