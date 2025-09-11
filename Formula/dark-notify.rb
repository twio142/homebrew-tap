class DarkNotify < Formula
  desc "Watcher for macOS 10.14+ light/dark mode changes"
  homepage "https://github.com/twio142/dark-notify"
  url "https://github.com/twio142/dark-notify/releases/download/v1.0.2-mod/dark-notify-arm64.tar.gz"
  sha256 "b15ebbc9eccfc4bed57b7c6e7142fe29577d5405bf4c30370ea059e6fd86d9ec"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install Dir["dark-notify*"].first => "dark-notify"
  end

  test do
    system bin/"dark-notify", "--help"
  end
end
