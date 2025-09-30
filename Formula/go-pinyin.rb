class GoPinyin < Formula
  desc "Go library for converting Chinese hanzi to pinyin"
  homepage "https://github.com/twio142/go-pinyin"
  url "https://github.com/twio142/go-pinyin/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "e7fca4a5537230f30b448feb648edee3b0eab214a9d6f0a0c977b953370ee17f"

  livecheck do
    url :homepage
    strategy :git
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/go-pinyin-v0.1.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5e28102fda073db33191bec5b7cb5acd3736570542ba9c16299f7d8fe9b4f2b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "368da54e6cfa44e60816629ce93948181dc09e1c43489c1c5dba2683488edf40"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"go-pinyin")
  end

  test do
    system bin/"go-pinyin", "-h"
  end
end
