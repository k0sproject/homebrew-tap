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
    sha256 cellar: :any_skip_relocation, big_sur:      "d7b6fcaed0dca29312cc9c4a4cf782d2190e8a3e0eee4ed82545ef184f16ba62"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e962e57606d199d012265439ae61c55e70e03253707e4c4361de647a1192f9ba"
  end

  depends_on "go@1.19" => :build

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
