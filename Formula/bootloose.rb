class Bootloose < Formula
  desc "Creates containers that look like virtual machines"
  homepage "https://github.com/k0sproject/bootloose"
  url "https://github.com/k0sproject/bootloose.git",
      tag:      "v0.9.6",
      revision: "7e66c94d6395e7fb1ac877740e1e8a96b5e6e3da"
  license "Apache-2.0"
  head "https://github.com/k0sproject/bootloose.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/bootloose-0.9.6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "42fd11014e4fbddda79c44d587c16e2b5f92161f4de6de01c61fedfdbfd393aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c6209fa639d543eba5ae9e3283b878018ba84d408d4ba1386b4978c0d516f72c"
  end

  depends_on "go" => :build

  def install
    system "make", "bootloose", "TAG_NAME=v#{version}"
    bin.install "bootloose"
    prefix.install ["LICENSE", "NOTICE", "README.md"]

    generate_completions_from_executable(bin/"bootloose", "completion")
  end

  test do
    version_output = shell_output("#{bin}/bootloose version")
    assert_match "v#{version}", version_output
  end
end
