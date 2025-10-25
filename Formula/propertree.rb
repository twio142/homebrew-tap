class Propertree < Formula
  desc "Cross-platform GUI plist editor written in python"
  homepage "https://github.com/corpnewt/ProperTree"
  url "https://github.com/corpnewt/ProperTree.git",
    using:    :git,
    revision: "a9a4108768338ad20c2fc1a1fe2422aff463017f"
  version "25.10.24-a9a41087"
  license "BSD-3-Clause"

  livecheck do
    url "https://github.com/corpnewt/ProperTree/commits/master.atom"
    strategy :page_match do |page|
      require "rexml/document"
      xml = REXML::Document.new(page)
      latest_commit_date = xml.elements["//entry/updated"]&.text
      link = xml.elements["//entry/link[@rel='alternate']"]
      href = link&.attributes&.[]("href")
      latest_commit_hash = href&.split("/")&.last
      next if latest_commit_date.blank? || latest_commit_hash.blank?

      "#{Date.parse(latest_commit_date).strftime("%y.%m.%d")}-#{latest_commit_hash[0..7]}"
    end
    regex(/\d{2}\.\d{2}\.\d{2}-[0-9a-f]{8}/i)
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/propertree-v25.10.24-a9a41087"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8b0b364d0cb67efb94ce6107253da45a30ea93976c5458102d6863d86f5f765e"
  end

  depends_on "python-tk@3.13"
  depends_on "python@3.13"

  def install
    libexec.install Dir["*"]

    python_executable = Formula["python@3.13"].opt_bin/"python3.13"

    system python_executable, libexec/"Scripts/buildapp-select.py", "-p", python_executable

    prefix.install libexec/"ProperTree.app"

    bin.install_symlink prefix/"ProperTree.app/Contents/MacOS/ProperTree.command" => "propertree"
    begin
      ln_sf opt_prefix/"ProperTree.app", "/Applications"
    rescue
      opoo "Could not create symlink to /Applications. You can manually create it with:"
      puts "  ln -s #{opt_prefix}/ProperTree.app /Applications/"
      puts "Or create a symlink to any other location of your choice."
    end
  end

  test do
    assert_predicate bin/"propertree", :executable?
  end
end
