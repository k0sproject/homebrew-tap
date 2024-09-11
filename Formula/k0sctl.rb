class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.19.0",
      revision: "9246ddc823198b572b51fb19bdf5effee4721a9d"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.18.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f5acd43f7e0c94dbfe0e6116ed668fbfc17478a25d3af30bc83c8e4bb200475f"
    sha256 cellar: :any_skip_relocation, ventura:      "7ceda2a9638b02819788ab524d487ef7b9c1fab633809db3469d41dd5affd5e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0df2ebf82bc3cc6bcfa16d94af2765960bdfb6ac34fd61b7d7acbdbd1ec4bbdf"
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
