class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.27.1",
      revision: "c7ee91b2f1a36c447590993cbb133028882271df"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.27.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6a2517cf6b1816cc8f68c8c7a25118fe42914362b5afea5fa0995cfd94ac762c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cdbdb4eb47a07e670d36eef9a0d6b9f2f33d7fabd17465806b68e44d7cbc646e"
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
