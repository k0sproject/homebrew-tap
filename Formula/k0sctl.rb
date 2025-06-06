class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.25.1",
      revision: "f797b609f6b016a59cb81940f2458038879a3e72"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.24.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "6a0f47abb263f6dd14a8f6c6f6460c6f0a3ef1f980d0d052e58179622ab1d3e4"
    sha256 cellar: :any_skip_relocation, ventura:      "962f6a0cbe71fb73bdb4bf591fdda0bff3137455d912302235ad08dee54f89cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2329a1f621efb6ff99421e69d4a7fac4616066a432780cf8a28aca378f6d44fa"
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
