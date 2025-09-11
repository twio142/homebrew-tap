class GoPinyin < Formula
  desc "Go library for converting Chinese hanzi to pinyin"
  homepage "https://github.com/twio142/go-pinyin"
  url "https://github.com/twio142/go-pinyin/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "e7fca4a5537230f30b448feb648edee3b0eab214a9d6f0a0c977b953370ee17f"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"go-pinyin")
  end

  test do
    system bin/"go-pinyin", "-h"
  end
end
