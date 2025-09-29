class Propertree < Formula
  desc "Cross-platform GUI plist editor written in python"
  homepage "https://github.com/corpnewt/ProperTree"
  url "https://github.com/corpnewt/ProperTree.git#25.09.28-7cd845d9",
    revision: "417837ad"
  version "25.09.28-7cd845d9"
  sha256 "9534a11ba1b01d0e78a96ec31552b27f84b62474f684d13164a0ad514d7811d2"
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
        #{prefix}/ProperTree.app
      To make it available in your /Applications folder, you can run:
        ln -s #{prefix}/ProperTree.app /Applications/
    EOS
  end

  test do
    assert_predicate bin/"propertree", :executable?
  end
end
