class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.19.1",
      revision: "06468474fdd8928666ea1faa2d5c32ac13e25103"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.19.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "841914daa01d974a50180c2cff241e48d3f85de5f20af20f6448d3a44a13bb98"
    sha256 cellar: :any_skip_relocation, ventura:      "be6db9cdb6799cd0669ec0aa5c7b381179bb684a5e6e1a06853df40981ab0329"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5b93d0691d68abd9c45f830f85d4409aadda2fe97fa18164e08588611c5e0d5f"
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
