class Propertree < Formula
  desc "Cross-platform GUI plist editor written in python"
  homepage "https://github.com/corpnewt/ProperTree"
  url "https://github.com/corpnewt/ProperTree.git#25.09.28-7cd845d9",
    revision: "7cd845d9"
  version "25.09.28-7cd845d9"
  sha256 "6dbd289927cba9ea7499e9e1363a53be8b5750aae50a2a01596353e81b48e17a"
  license "BSD-3-Clause"

  livecheck do
    url "https://github.com/corpnewt/ProperTree/commits/master.atom"
    strategy :page_match do |page|
      require "rexml/document"
      xml = REXML::Document.new(page)
      latest_commit_date = xml.elements["//entry/updated"]&.text
      latest_commit_hash = xml.elements["//entry/link[@rel='alternate']"]&.attributes&.[]("href")&.split("/")&.last
      next if latest_commit_date.blank? || latest_commit_hash.blank?
      "#{Date.parse(latest_commit_date).strftime("%y.%m.%d")}-#{latest_commit_hash[0..7]}"
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
