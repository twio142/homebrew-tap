class Ttyd < Formula
  desc "Command-line tool for sharing terminal over the web"
  homepage "https://github.com/twio142/"
  version "1.7.7-mod"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/twio142/ttyd/releases/download/v#{version}/ttyd-arm64-macos.tar.gz"
      sha256 "7f00cba9ab3acb6d3bfb69b01662d8daf1dbc3b4171630dc307acad5549dd623"
    else
      url "https://github.com/twio142/ttyd/releases/download/v#{version}/ttyd-x86_64-macos.tar.gz"
      sha256 "8cd1b3ef48b9dec4cbd080c4279106966900517fb522fed34b6dcd6bbd1910dc"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/twio142/ttyd/releases/download/v#{version}/ttyd-x86_64-linux.tar.gz"
      sha256 "a6f99c82de6a41cb068853b2d4fa767ae2e5e839dc5fa40a2caa5e368cec1c50"
    end
  end

  def install
    bin.install Dir["ttyd*"].first => "ttyd"
  end

  test do
    port = free_port
    fork do
      system bin/"ttyd", "--port", port.to_s, "bash"
    end
    sleep 5

    system "curl", "-sI", "http://localhost:#{port}"
  end
end
