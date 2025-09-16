class Propertree < Formula
  desc "Cross-platform GUI plist editor written in python"
  homepage "https://github.com/corpnewt/ProperTree"
  url "https://github.com/corpnewt/ProperTree/archive/417837adc32a9e0ffa4895074889ebf4f52e6c80.zip"
  version "2025.08.31"
  sha256 "8913d3ef352bc5bbb5f936fffa4e133a170bb580d23bc2310dafeb7e2d3115e3"

  depends_on "python@3.13"
  depends_on "python-tk@3.13"

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
