class Bootloose < Formula
  desc "Creates containers that look like virtual machines"
  homepage "https://github.com/k0sproject/bootloose"
  url "https://github.com/k0sproject/bootloose.git",
      tag:      "v0.9.0",
      revision: "124c22f5c2d32e26d91995579ca184876d5a9195"
  license "Apache-2.0"
  head "https://github.com/k0sproject/bootloose.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/bootloose-0.8.0"
    sha256 cellar: :any_skip_relocation, ventura: "be3d022ef52c4978eff2fe8660894debac351fa29a9aed7383e472e8ed05386b"
  end

  depends_on "go" => :build

  def install
    system "make", "bootloose", "TAG_NAME=v#{version}"
    bin.install "bootloose"
    prefix.install ["LICENSE", "NOTICE", "README.md"]

    generate_completions_from_executable(bin/"bootloose", "completion")
  end

  test do
    version_output = shell_output(bin/"bootloose version 2>&1")
    assert_match "v#{version}", version_output
  end
end
