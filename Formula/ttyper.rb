class Ttyper < Formula
  desc "Terminal-based typing test"
  homepage "https://github.com/max-niederman/ttyper"
  url "https://github.com/max-niederman/ttyper/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "f7e4ff2f803483b17f35aa0c02977326a0546a95f5b465b4dd34ff17e45b4021"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/ttyper-v1.6.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a9443a0ea52f360e1d351e28353fb983900df24ffff259beaac7455f4a642c24"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2165507a4b26781f491217dd7c7df30a336150db113e3ac35def602f14acffb"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"ttyper", "--version"
  end
end
