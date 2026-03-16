class GoPinyin < Formula
  desc "Go library for converting Chinese hanzi to pinyin"
  homepage "https://github.com/twio142/go-pinyin"
  url "https://github.com/twio142/go-pinyin/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "ee074a8b33a56ca93517997f62f19133e08777163f38ef0e23cf3162257ef44e"

  livecheck do
    url :homepage
    strategy :git
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/go-pinyin-v0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d72ae96487dbdda338cc73d1b383fd60ade5d7253b5809d36e54715634f89526"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "acee78ec17c0d7406176dc0de7ec4d6f7e1ffd79a2730903127c2a5babf8f7db"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"go-pinyin")
  end

  test do
    system bin/"go-pinyin", "-h"
  end
end
