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

  depends_on "rust" => :build
  depends_on "librime"

  def install
    # Set environment variables to point to the Homebrew-installed librime
    ENV["LIBRIME_INCLUDE_DIR"] = Formula["librime"].opt_include
    ENV["LIBRIME_LIB_DIR"] = Formula["librime"].opt_lib

    system "cargo", "build", "--release"
    bin.install "target/release/rime_ls"
  end

  test do
    system bin/"rime_ls", "--help"
  end
end
