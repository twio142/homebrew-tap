class RimeLs < Formula
  desc "Language server for text input with rime"
  homepage "https://github.com/wlh320/rime-ls"
  url "https://github.com/wlh320/rime-ls/archive/refs/tags/v0.4.3.tar.gz"
  sha256 "38a13b1ba9cbf833a0d96c12a0b4cc38c8feb73d6efbd3c4002e498ab29a3d2b"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "7fa535bf0c83a065a69a205656bf9eecd0c9f179ada1f3865d5e173b30450293"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db122e5fdc277f39f8922115dc8a216f2e3995538c08ccde86631de391cd44ba"
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
