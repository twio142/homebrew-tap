class DarkNotify < Formula
  desc "Watcher for macOS 10.14+ light/dark mode changes"
  homepage "https://github.com/twio142/dark-notify"
  version "..."
  sha256 "..."
  url "https://github.com/twio142/dark-notify/releases/download/v#{version}/dark-notify-arm64"

  def install
    bin.install "dark-notify-arm64" => "dark-notify"
  end

  test do
    system "#{bin}/dark-notify", "--help"
  end
end
