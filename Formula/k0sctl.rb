class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.19.4",
      revision: "a06d3f6c227d15c3c7f1b87205ee6b32a2000521"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.19.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "888af0a4be3ea4a88b8223149cad1c0f37070e0537812a7042e4397bc2b1dc44"
    sha256 cellar: :any_skip_relocation, ventura:      "683474bc76265109fcde90189bdde798c06e99b3effbfb35079dea0b02f8b4b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7e4095552f67a558805c15c0b18af040507d93c72331e57b9fe1367d2eb222cb"
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
