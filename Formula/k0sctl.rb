class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.15.5",
      revision: "5e11c5656e971ab4b630a4b771ec88b4cd59b652"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.15.4"
    sha256 cellar: :any_skip_relocation, ventura:      "aaa451a0e7351ddd02328f77f74058714620d1549ab28bc7706d230d8401caaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ac1e8b2f1fad50e65c156baad7ead41a2bad330b0a04bebef6d1082113a1aaa6"
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
