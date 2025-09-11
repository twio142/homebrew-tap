class RimeLs < Formula
  desc "Language server for text input with rime"
  homepage "https://github.com/twio142/rime-ls"
  version "0.4.3-mod"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/twio142/rime-ls/releases/download/v#{version}/rime_ls-aarch64-apple-darwin.tar.gz"
      sha256 "58e201a7be3cfaf73e384f135e8c74c25d784662019157031b17be18d71d3e1b"
    else
      url "https://github.com/twio142/rime-ls/releases/download/v#{version}/rime_ls-x86_64-apple-darwin.tar.gz"
      sha256 "5f3535e1b8581c958e287e56922210f72da697ec6bbe5a45d0c6a78b929244c2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/twio142/rime-ls/releases/download/v#{version}/rime_ls-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cc53ebc590fa0a9c12b41bdba1dd4c1767fff50d7436abff01afd8ee2e461bf1"
    end
  end

  def install
    bin.install Dir["rime_ls*"].first => "rime_ls"
  end
end
