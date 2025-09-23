class DarkNotify < Formula
  desc "Watcher for macOS 10.14+ light/dark mode changes"
  homepage "https://github.com/cormacrelf/dark-notify"
  url "https://github.com/cormacrelf/dark-notify/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "b15ebbc9eccfc4bed57b7c6e7142fe29577d5405bf4c30370ea059e6fd86d9ec"
  head "https://github.com/cormacrelf/dark-notify.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build
  depends_on arch: :arm64
  depends_on :macos

  def install
    system "rustup", "toolchain", "install", "nightly"
    system "cargo", "+nightly", "install", *std_cargo_args
  end

  test do
    system bin/"dark-notify", "--help"
  end
end
