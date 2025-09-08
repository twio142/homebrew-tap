class GoPinyin < Formula
  desc "A Go library for converting Chinese hanzi to pinyin"
  homepage "https://github.com/twio142/go-pinyin"
  version "..."
  sha256 "..."
  url "https://github.com/twio142/go-pinyin/archive/refs/tags/v#{version}.tar.gz"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", "go-pinyin", "./cmd/pinyin"
    bin.install "go-pinyin"
  end
end
