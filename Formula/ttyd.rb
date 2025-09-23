class Ttyd < Formula
  desc "Command-line tool for sharing terminal over the web"
  homepage "https://github.com/tsl0922/ttyd"
  url "https://github.com/tsl0922/ttyd/archive/refs/tags/1.7.7.tar.gz"
  sha256 "039dd995229377caee919898b7bd54484accec3bba49c118e2d5cd6ec51e3650"
  head "https://github.com/tsl0922/ttyd.git", branch: "main"
  license "MIT"
  head "https://github.com/tsl0922/ttyd.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    rebuild 1
    sha256 arm64_sequoia: "b41654b6ba6af018bb59657a9e011d1d18e619c167c482229d07f065acbeebff"
    sha256 x86_64_linux:  "181d4ab9270d5618b948e6d8f073b4179a71f7e7a3adfc41e8a2b17a75b9dcb6"
  end

  depends_on "cmake" => :build
  depends_on "node" => :build
  depends_on "json-c"
  depends_on "libwebsockets"

  def install
    inreplace "html/src/components/app.tsx" do |s|
      s.gsub!(/fontSize: \d+/, "fontSize: 12")
      s.gsub!("fontFamily: '", "fontFamily: 'JetBrainsMono NF,")
      s.gsub!(/background: '.*'/, "background: 'transparent'")
    end

    inreplace "html/webpack.config.js" do |s|
      s.sub!("rules: [", "rules: [ { test: /\\.(ttf|otf|eot|woff|woff2)$/, type: 'asset/inline' },")
    end

    font_faces = <<~EOS
      @font-face { font-family: 'JetBrainsMono NF'; font-style: normal; font-weight: normal; font-display: swap; src: url(../JetBrainsMonoNF-Regular.woff2) format('woff2'); }
      @font-face { font-family: 'JetBrainsMono NF'; font-style: normal; font-weight: bold; font-display: swap; src: url(../JetBrainsMonoNF-Bold.woff2) format('woff2'); }
      @font-face { font-family: 'JetBrainsMono NF'; font-style: italic; font-weight: normal; font-display: swap; src: url(../JetBrainsMonoNF-Italic.woff2) format('woff2'); }
      @font-face { font-family: 'JetBrainsMono NF'; font-style: italic; font-weight: bold; font-display: swap; src: url(../JetBrainsMonoNF-BoldItalic.woff2) format('woff2'); }
    EOS
    File.open("html/src/style/index.scss", "a") { |f| f.write("\n" + font_faces) }

    tap_resources_path = tap.path/"resources/ttyd"
    cp tap_resources_path/"JetBrainsMonoNF-Bold.woff2", buildpath/"html/src/"
    cp tap_resources_path/"JetBrainsMonoNF-BoldItalic.woff2", buildpath/"html/src/"
    cp tap_resources_path/"JetBrainsMonoNF-Italic.woff2", buildpath/"html/src/"
    cp tap_resources_path/"JetBrainsMonoNF-Regular.woff2", buildpath/"html/src/"

    cd "html" do
      ENV.prepend_path "PATH", Formula["node"].opt_bin
      system "corepack", "use", "yarn@3.6.3"
      system "corepack", "yarn", "install"
      system "corepack", "yarn", "run", "build"
    end

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
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
