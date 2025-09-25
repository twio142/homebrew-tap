class Ttyd < Formula
  desc "Command-line tool for sharing terminal over the web"
  homepage "https://github.com/tsl0922/ttyd"
  url "https://github.com/tsl0922/ttyd/archive/refs/tags/1.7.7.tar.gz"
  sha256 "039dd995229377caee919898b7bd54484accec3bba49c118e2d5cd6ec51e3650"
  license "MIT"
  head "https://github.com/tsl0922/ttyd.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/twio142/homebrew-tap/releases/download/ttyd-v1.7.7"
    rebuild 1
    sha256 arm64_sequoia: "5a7d794c06b6faead940e4283dfda5d94d19b354d5ac24e6d4e372ab6b3d7eb3"
    sha256 x86_64_linux:  "5cffa72a1b7d06bce52f28caa240c83f6267061349801dfcaec7de596e553b04"
  end

  depends_on "cmake" => :build
  depends_on "node" => :build
  depends_on "json-c"
  depends_on "libwebsockets"

  resource "fonts" do
    url "https://github.com/twio142/homebrew-tap/releases/download/ttyd-resources/fonts.tar.gz"
    sha256 "5aadfd13ebb7388832ba3b61d36b653ee9fae4d15f2ea501db964d11ef13d07e"
  end

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

    resource("fonts").stage do
      (buildpath/"html/src").install Dir["*.woff2"]
    end

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
