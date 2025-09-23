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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "4fcb33747ad53b40ce13e69489b9e3b412d71d37514eff6d23c2546fd82bba23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5e19a29bdcf5b1494a2645c4af9882794e2e41d68624bc343c02f354c5411a9"
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
