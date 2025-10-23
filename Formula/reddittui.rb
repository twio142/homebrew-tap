class Reddittui < Formula
  desc "Terminal UI for reddit"
  homepage "https://github.com/tonymajestro/reddit-tui"
  url "https://github.com/tonymajestro/reddit-tui/archive/refs/tags/v0.3.9.tar.gz"
  sha256 "4f5dad492b776e67f9ed94fdc7bbcccabaa921ffdba7eb184619a830d05b5a33"
  license "MIT"

  livecheck do
    url :homepage
    strategy :git
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/reddittui-v0.3.9"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7979771708766eef0b2ec1fc2c273aab99f54094521e0fec6f3f753c4cfa836b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "92f4b1fdd85ed0afb62f63d11ec5db3e945abe73469e8df3265de199b1d42765"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"reddittui")
  end

  test do
    system bin/"reddittui", "-h"
  end
end
