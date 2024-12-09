class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.20.0",
      revision: "b361d94bb457aeb44678015241ee735aed34a335"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.20.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d1a6edb278c0447e53b3e161e263ae3862e067099e1914762932ac7141c67fe7"
    sha256 cellar: :any_skip_relocation, ventura:      "f578063af15c535e7ae4afbb54c6f97c8e84833a46a127d7824d3ffd5fba960c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e2cd59de0a58a3e444e68cf49bfaa0e2ffa737e98db6f9cf24124f0c1570e4cd"
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
