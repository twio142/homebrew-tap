class GoPinyin < Formula
  desc "Go library for converting Chinese hanzi to pinyin"
  homepage "https://github.com/twio142/go-pinyin"
  url "https://github.com/twio142/go-pinyin/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "71b1469f2a0569deed9e75c06f9c962aef4500afaf81cd8a6959f50bdb8601cc"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"go-pinyin")
  end

  test do
    system bin/"go-pinyin", "-h"
  end
end
