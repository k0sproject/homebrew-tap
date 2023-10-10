class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.16.0",
      revision: "7e8c2726efda66932ba10a65aef10eaa9eb4b3ea"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.16.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, ventura:      "cc9eceb3ef0287c8d8e5201a973d38c2ea158c5fa03b67e23db445eae2e0dce4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d37fe0b6e1c2b414834b60582ffd7406e7606cf4481ad05f7e2151613b8f33c6"
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
