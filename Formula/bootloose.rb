class Bootloose < Formula
  desc "Creates containers that look like virtual machines"
  homepage "https://github.com/k0sproject/bootloose"
  url "https://github.com/k0sproject/bootloose.git",
      tag:      "v0.7.3",
      revision: "8a83360fb81b6bcfed2ae52f9aed7b841c3f7d09"
  license "Apache-2.0"
  head "https://github.com/k0sproject/bootloose.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/bootloose-0.7.3"
    sha256 cellar: :any_skip_relocation, ventura: "615c186ec3ce7cf01f337355df9cbf6cf6bc2100cd191f54c235fa07e3b80e78"
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
