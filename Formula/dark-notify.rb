class DarkNotify < Formula
  desc "Watcher for macOS 10.14+ light/dark mode changes"
  homepage "https://github.com/cormacrelf/dark-notify"
  url "https://github.com/cormacrelf/dark-notify/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "468bce03cd5e6f0d8c56253293fa3f9334fbb354dc189958a0573a9d9232dca7"
  head "https://github.com/cormacrelf/dark-notify.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/dark-notify-v0.1.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "36ecda871f3eceef8bc35a6a1cedb06be423103dc96f32220a8cf7694802e91b"
  end

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"dark-notify", "--help"
  end
end
