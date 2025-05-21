class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.24.0",
      revision: "fffc42bb5cdde98d237da23970543aee2c37e387"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.23.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "34abf019ace7fc57a8f0023fe9d2afa78aec0b29afd7e9948939a6d98f939fa0"
    sha256 cellar: :any_skip_relocation, ventura:      "032f6744e9596d1049de74e8c46a896da87835f58c9fbcaef5fb21417db81002"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bc2ee6b0c7710128a21d3b5f9914118a99ffcd54724b81f8e948f3e35f0c9804"
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
