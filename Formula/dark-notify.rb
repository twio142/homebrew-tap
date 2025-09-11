class DarkNotify < Formula
  desc "Watcher for macOS 10.14+ light/dark mode changes"
  homepage "https://github.com/twio142/dark-notify"
  url "https://github.com/twio142/dark-notify/releases/download/v1.0.1-mod/dark-notify-arm64.tar.gz"
  version "1.0.1-mod"
  sha256 "..."

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install Dir["dark-notify*"].first => "dark-notify"
  end

  test do
    system "#{bin}/dark-notify", "--help"
  end
end
