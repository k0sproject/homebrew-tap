class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.22.0",
      revision: "929602e5d57527e1bdf39d607555e3d031f2cf5e"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.21.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "7ef5999ada2492aa70a711d19374eecead4859ba3b7baad63f12e0c77a96b192"
    sha256 cellar: :any_skip_relocation, ventura:      "e595b27120340e0764edd6ca561482997571d6e38be9ac19f1a7b6a8d8edb18f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "df524f2e4b0d4afa7ae25290205a12f9df07f8450310d18846a8f58b120ebcef"
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
