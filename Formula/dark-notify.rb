class DarkNotify < Formula
  desc "Watcher for macOS 10.14+ light/dark mode changes"
  homepage "https://github.com/cormacrelf/dark-notify"
  url "https://github.com/cormacrelf/dark-notify/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "802aee7ea3e3dd6bf5a8a4b451b9310582fc9f04a336907affd19f97a8cda679"
  head "https://github.com/cormacrelf/dark-notify.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build
  depends_on arch: :arm64
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"dark-notify", "--help"
  end
end
