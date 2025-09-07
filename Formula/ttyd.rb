class Ttyd < Formula
  desc "Command-line tool for sharing terminal over the web"
  homepage "https://github.com/twio142/"
  version "1.7.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/twio142/ttyd/releases/download/v#{version}/ttyd-aarch64-apple-darwin"
      sha256 "..." # placeholder
    else
      url "https://github.com/twio142/ttyd/releases/download/v#{version}/ttyd-x86_64-apple-darwin"
      sha256 "..." # placeholder
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/twio142/ttyd/releases/download/v#{version}/ttyd-x86_64-unknown-linux-gnu"
      sha256 "..." # placeholder
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
