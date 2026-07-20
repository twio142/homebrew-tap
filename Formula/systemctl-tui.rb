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
    root_url "https://github.com/twio142/homebrew-tap/releases/download/systemctl-tui-v0.7.0"
    sha256 cellar: :any, x86_64_linux: "b5060955b441d6b48800be9bcbed20285214b732cd6e30cd8237e3694758373c"
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
