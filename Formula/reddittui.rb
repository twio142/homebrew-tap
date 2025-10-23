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

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"reddittui")
  end

  test do
    system bin/"reddittui", "-h"
  end
end
