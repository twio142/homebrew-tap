class GoPinyin < Formula
  desc "A Go library for converting Chinese hanzi to pinyin"
  homepage "https://github.com/twio142/go-pinyin"
  url "https://github.com/twio142/go-pinyin/archive/refs/tags/v....tar.gz"
  version "..."
  sha256 "..."

  depends_on "go" => :build

  def install
    system "go", "build", "-o", "go-pinyin", "./cmd/pinyin"
    bin.install "go-pinyin"
  end
end
