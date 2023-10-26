class Bootloose < Formula
  desc "Creates containers that look like virtual machines"
  homepage "https://github.com/k0sproject/bootloose"
  url "https://github.com/k0sproject/bootloose.git",
      tag:      "v0.7.2",
      revision: "bd4e26304abc6908bba1515295dbd42129b47c4d"
  license "Apache-2.0"
  head "https://github.com/k0sproject/bootloose.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/bootloose-0.7.2"
    sha256 cellar: :any_skip_relocation, ventura:      "5575e618a7f38028bf47b4744be6ca276fb6b5f6f7be5449d0ad6e6bc171d9eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3fe55121dac4e4066961cd8d0e67c5633615886d9c003744c830d850f62de57a"
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
