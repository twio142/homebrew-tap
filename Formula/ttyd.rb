class Ttyd < Formula
  desc "Command-line tool for sharing terminal over the web"
  homepage "https://github.com/twio142/"
  version "..."
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/twio142/ttyd/releases/download/v#{version}/ttyd-arm64-macos.tar.gz"
      sha256 "..."
    else
      url "https://github.com/twio142/ttyd/releases/download/v#{version}/ttyd-x86_64-macos.tar.gz"
      sha256 "..."
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/twio142/ttyd/releases/download/v#{version}/ttyd-x86_64-linux.tar.gz"
      sha256 "..."
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
