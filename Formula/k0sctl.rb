class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.27.0",
      revision: "14ccbf5d395b90c683e8a4324a7b34e6b0bdb80e"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.26.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4e1d3949eb1fd54c6dd2617d39e4a3588b1b83f3e7807e88c4f0e13439760261"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2149f8e5dcf346024d6a6e2baa95fbbe4e5e5214d2c4dd259bd651dc50c6bf3"
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
