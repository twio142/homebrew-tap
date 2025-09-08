class Battery < Formula
  desc "CLI for managing battery charging"
  homepage "https://github.com/twio142/battery/"
  version "..."
  sha256 "..."
  url "https://github.com/twio142/battery/releases/download/v#{version}/battery"

  def install
    bin.install "battery"
  end

  test do
    system "#{bin}/battery"
  end
end
