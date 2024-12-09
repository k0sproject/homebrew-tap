class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.20.0",
      revision: "b361d94bb457aeb44678015241ee735aed34a335"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.19.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5dad2e582554ee61b6fbfbeac1d354cce9260b49c37f008ade6d7a8e2cef2c58"
    sha256 cellar: :any_skip_relocation, ventura:      "b332812dd5c82df5a80e84fc6d512ae159d8e6e1dc68d62066013a101371bd12"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5368c8c810bd6da4f6e90992f3658afa32623381020309db5efd8392c2569304"
  end

  depends_on "go" => :build

  def install
    system "make", "k0sctl", "TAG_NAME=v#{version}"
    bin.install "k0sctl"
    prefix.install_metafiles

    generate_completions_from_executable(
      bin/"k0sctl", "completion",
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
