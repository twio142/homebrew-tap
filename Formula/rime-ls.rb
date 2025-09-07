class RimeLs < Formula
  desc "Language server for text input with rime"
  homepage "https://github.com/twio142/rime-ls"
  version "0.1.0" # placeholder

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/twio142/rime-ls/releases/download/v#{version}/rime_ls-aarch64-apple-darwin"
      sha256 "..." # placeholder
    else
      url "https://github.com/twio142/rime-ls/releases/download/v#{version}/rime_ls-x86_64-apple-darwin"
      sha256 "..." # placeholder
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/twio142/rime-ls/releases/download/v#{version}/rime_ls-x86_64-unknown-linux-gnu"
      sha256 "..." # placeholder
    end
  end

  def install
    bin.install Dir["rime_ls*"].first => "rime_ls"
  end
end
