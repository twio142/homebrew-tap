class RimeLs < Formula
  desc "Language server for text input with rime"
  homepage "https://github.com/wlh320/rime-ls"
  url "https://github.com/wlh320/rime-ls/archive/refs/tags/v0.4.3.tar.gz"
  sha256 "38a13b1ba9cbf833a0d96c12a0b4cc38c8feb73d6efbd3c4002e498ab29a3d2b"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "18c94d70613756d534c9830e9577e8f6a449ab085af01ea7bed2545bc851dff8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3a9ed1a187a684a418e0053c7a0e6d2f3556cd16a6543d68b0dfbe7e1a6a98fd"
  end

  depends_on "rust" => :build
  depends_on "librime"

  def install
    ENV["LIBRIME_INCLUDE_DIR"] = Formula["librime"].opt_include
    ENV["LIBRIME_LIB_DIR"] = Formula["librime"].opt_lib

    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"rime_ls", "--help"
  end
end
