class Ttyd < Formula
  desc "Command-line tool for sharing terminal over the web"
  homepage "https://github.com/tsl0922/ttyd"
  url "https://github.com/tsl0922/ttyd/archive/refs/tags/1.7.7.tar.gz"
  sha256 "039dd995229377caee919898b7bd54484accec3bba49c118e2d5cd6ec51e3650"
  head "https://github.com/tsl0922/ttyd.git", branch: "main"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "cmake" => :build
  depends_on "node" => :build
  depends_on "json-c"
  depends_on "libwebsockets"

  resource "jetbrainsmono-bold" do
    url "https://raw.githubusercontent.com/twio142/homebrew-tap/master/resources/ttyd/JetBrainsMonoNF-Bold.woff2"
    sha256 "c09e32b3ad3f44a2fb41db730c01bd56588db7f0aa27c01854ad979fac2394d9"
  end

  resource "jetbrainsmono-bolditalic" do
    url "https://raw.githubusercontent.com/twio142/homebrew-tap/master/resources/ttyd/JetBrainsMonoNF-BoldItalic.woff2"
    sha256 "56389785138d9803322b6155a13e06d5045cbfa9c439c6c74869801f685b6f0e"
  end

  resource "jetbrainsmono-italic" do
    url "https://raw.githubusercontent.com/twio142/homebrew-tap/master/resources/ttyd/JetBrainsMonoNF-Italic.woff2"
    sha256 "a6b98dcdef1e4c4b02d95e9c2d0550a8218b5a1d63c2b05b89a685edc2c8d6a5"
  end

  resource "jetbrainsmono-regular" do
    url "https://raw.githubusercontent.com/twio142/homebrew-tap/master/resources/ttyd/JetBrainsMonoNF-Regular.woff2"
    sha256 "909f0f61256c129559fb528382887c481f3944a4c71a6a1d06311fc61c2408da"
  end

  patch do
    url "https://raw.githubusercontent.com/twio142/homebrew-tap/master/patches/ttyd.patch"
    sha256 "187a0163bd5347a2e72e312d828e28677a88609f7275ca07cc5f974d7a638a98"
  end

  def install
    (buildpath/"html/src").install resource("jetbrainsmono-bold")
    (buildpath/"html/src").install resource("jetbrainsmono-bolditalic")
    (buildpath/"html/src").install resource("jetbrainsmono-italic")
    (buildpath/"html/src").install resource("jetbrainsmono-regular")

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
