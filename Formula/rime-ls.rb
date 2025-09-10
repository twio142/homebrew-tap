class RimeLs < Formula
  desc "Language server for text input with rime"
  homepage "https://github.com/twio142/rime-ls"
  version "0.4.3-mod"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/twio142/rime-ls/releases/download/v#{version}/rime_ls-aarch64-apple-darwin.tar.gz"
      sha256 "f43307b4a4d51c0ec20c5385ec7e988d4c5be53f4687e7635fc69cd3200c9f4a"
    else
      url "https://github.com/twio142/rime-ls/releases/download/v#{version}/rime_ls-x86_64-apple-darwin.tar.gz"
      sha256 "347972311bdc8691b2cf0d9f7642a2cb8009179a404ea47a9ab3fcfef8799978"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/twio142/rime-ls/releases/download/v#{version}/rime_ls-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e6e9329cd8b605680104dc541d79444255276e4798e395317b81a073503f0453"
    end
  end

  def install
    bin.install Dir["rime_ls*"].first => "rime_ls"
  end
end
