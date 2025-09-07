class Battery < Formula
  desc "CLI for managing battery charging"
  homepage "https://github.com/twio142/battery/"
  url "https://github.com/twio142/battery/releases/download/v#{version}/battery"
  version "1.2.7"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000" # placeholder

  def install
    bin.install "battery"
  end

  test do
    system "#{bin}/battery"
  end
end
