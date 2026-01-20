class Bootloose < Formula
  desc "Creates containers that look like virtual machines"
  homepage "https://github.com/k0sproject/bootloose"
  url "https://github.com/k0sproject/bootloose.git",
      tag:      "v0.9.5",
      revision: "77b6c0d560e7e11f06dfe9ad66a65abbda1cbdd9"
  license "Apache-2.0"
  head "https://github.com/k0sproject/bootloose.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/bootloose-0.9.5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "46cf43284a398ca3decd28f9c7f6a6ce078d497285990e421ca5064b14ecbb7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7454387d2482a427a64f13a70faa2780895f10b7fc48fcfb5facd075f1680927"
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
