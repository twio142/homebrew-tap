class SystemctlTui < Formula
  desc "Fast, simple TUI for interacting with systemd services and their logs"
  homepage "https://github.com/rgwood/systemctl-tui"
  url "https://github.com/rgwood/systemctl-tui/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "1c77ba06ece0866c6680eb52c2842d65ed688e273d9eb2e310106cdfa841d701"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/systemctl-tui-v0.5.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "94962ad7f50878aedc8e386fdbea78b901063fa20b5de4baf7bb1c58e678d821"
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
