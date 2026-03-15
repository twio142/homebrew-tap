class SystemctlTui < Formula
  desc "Fast, simple TUI for interacting with systemd services and their logs"
  homepage "https://github.com/rgwood/systemctl-tui"
  url "https://github.com/rgwood/systemctl-tui/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "243c8eb7b470db326181253ca8e354448ed02ded961e0b6d0edd657302ef680d"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
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
