class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.28.0",
      revision: "bad9a8d3e83de317c65638681c7a895f1af81614"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.27.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9c7cc91dec3875cafa594fad701c9a89358773fd8e769cc64aa4fac4c8d3ef70"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7062ca244a97df30fd37d399b1da399910ac0ec3d4800cd82ebc30b7b1e9461"
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
    version_output = shell_output("#{bin}/k0sctl version 2>&1")
    assert_match "version: v#{version}", version_output
    init_output = shell_output("#{bin}/k0sctl init root@10.0.0.1 2>&1")
    assert_match "address: 10.0.0.1", init_output
  end
end
