class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.14.0",
      revision: "0cbfc474fbaa7f1e1e5e88de5cb5a35ef360170e"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.14.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:      "f8eb0e2d627f6dc48e0e5bacc6afd18d3a71202c24c60286cd8162a117394a0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7b3a6790cef4aa4107808a45bedf82716710248b286935e28e4b2aa782cc5d53"
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
