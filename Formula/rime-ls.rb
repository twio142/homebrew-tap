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
    root_url "https://github.com/twio142/homebrew-tap/releases/download/rime-ls-v0.4.3"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "568f8e25d1e5c80045c620118e784b54cf80cadc338f59d87489dc42f3c40e09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6664104c285fbc33ade41a554897505c2e7314a10db78fda124bddbcdf52b983"
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
