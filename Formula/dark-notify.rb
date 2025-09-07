class DarkNotify < Formula
  desc "Watcher for macOS 10.14+ light/dark mode changes"
  homepage "https://github.com/twio142/dark-notify"
  version "0.1.2"
  url "https://github.com/twio142/dark-notify/releases/download/v#{version}/dark-notify-arm64"
  sha256 "987c4e40ca9f7996f72d8967a74417e2fc7e8d7aea02e93bd314f80a80817f9a"

  def install
    bin.install "dark-notify-arm64" => "dark-notify"
  end

  test do
    system "#{bin}/dark-notify", "--help"
  end
end
