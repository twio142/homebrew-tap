class Propertree < Formula
  desc "Cross-platform GUI plist editor written in python"
  homepage "https://github.com/corpnewt/ProperTree"
  url "https://github.com/corpnewt/ProperTree#25.08.31-417837ad",
    revision: "417837ad"
  version "25.08.31-417837ad"
  sha256 "958f9320b3db36987dd323db7731549cfec0e35d4bf3e5b8a2ca2e9b3c458a38"
  license "BSD-3-Clause"

  livecheck do
    url "https://api.github.com/repos/corpnewt/ProperTree/commits"
    strategy :page_match do |page|
      require "json"
      data = JSON.parse(page).first
      Date.parse(data["commit"]["committer"]["date"]).strftime("%y.%m.%d") + "-" + data["sha"][0..7]
    end
    regex(/\d{2}\.\d{2}\.\d{2}-[0-9a-f]{8}/i)
  end

  depends_on "python-tk@3.13"
  depends_on "python@3.13"

  def install
    libexec.install Dir["*"]

    python_executable = Formula["python@3.13"].opt_bin/"python3"

    system python_executable, libexec/"Scripts/buildapp-select.py", "-p", python_executable

    prefix.install libexec/"ProperTree.app"

    bin.install_symlink prefix/"ProperTree.app/Contents/MacOS/ProperTree.command" => "propertree"
  end

  def caveats
    <<~EOS
      ProperTree.app is installed to:
        #{opt_prefix}/ProperTree.app
      To make it available in your /Applications folder, you can run:
        ln -s #{opt_prefix}/ProperTree.app /Applications/
    EOS
  end

  test do
    assert_predicate bin/"propertree", :executable?
  end
end
