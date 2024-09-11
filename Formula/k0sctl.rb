class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.19.0",
      revision: "9246ddc823198b572b51fb19bdf5effee4721a9d"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.19.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "ec06786097d9cd8636aad708a0034549d326a2779849c355739be88303483d1e"
    sha256 cellar: :any_skip_relocation, ventura:      "a2f44935bad2cc55969534a2daf96a8c084e696bb75fd5c92b1660394ade2c96"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "df934249e6b530b14855e6d35ad7ce237b53126e2ba77ed970a53647f796ee69"
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
