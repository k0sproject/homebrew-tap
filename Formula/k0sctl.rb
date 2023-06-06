class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.15.2",
      revision: "5300b1cf907e6b649807d53e47f4c6fd902fc740"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.15.2"
    sha256 cellar: :any_skip_relocation, ventura:      "d0bbc908562ec69a36d92d70a072267c0a4cb5a02a8033882c766023e3aa7bdb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e76a75827838e35a7a15e17ad26d7d97dd390b1bcd32d75d9d4033fd92a77882"
  end

  depends_on "go" => :build

  def install
    system "make", "k0sctl", "TAG_NAME=v#{version}"
    bin.install "k0sctl"
    prefix.install_metafiles

    generate_completions_from_executable(
      bin/"k0sctl", "completion",
      ["bash", "zsh", "fish"],
      shell_parameter_format: :arg
    )
  end

  test do
    version_output = shell_output(bin/"k0sctl version 2>&1")
    assert_match "version: v#{version}", version_output
    init_output = shell_output(bin/"k0sctl init root@10.0.0.1 2>&1")
    assert_match "address: 10.0.0.1", init_output
  end
end
