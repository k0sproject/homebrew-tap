class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.23.0",
      revision: "2b58332880abd68b094303820f7df81e4c869d4b"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.22.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8b9866d9d4d71b8d27a2e15e3924a083966c5282580d7a691bd9169341347425"
    sha256 cellar: :any_skip_relocation, ventura:      "96487779af4af30e05f96adeb1684540642ffc69734735a1670b3aac9fbd21e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7fe5b049dfe2de75622e08fafb69ee726ebf4287fa06c4f2747658b56328784d"
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
