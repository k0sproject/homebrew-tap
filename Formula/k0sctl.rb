class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.15.0",
      revision: "b0cd9d9807d03df8e542d09dc53150e90cf950ec"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.15.0"
    sha256 cellar: :any_skip_relocation, monterey:     "f20852363da796502e01cac1b27f4ac156f2ecd937fc3e9ed277e76629a5682b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6da40546e9cae4ba17bad594cd1f00557ffa7b9e37663b586deb8fd50560f0bb"
  end

  depends_on "go" => :build

  def install
    system "make", "k0sctl", "TAG_NAME=v#{version}"
    bin.install "k0sctl"
    prefix.install_metafiles

    generate_completions_from_executable(
      bin/"k0sctl", "completion",
      ["bash", "zsh", "fish"],
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
