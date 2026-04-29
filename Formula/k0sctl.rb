class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.30.0",
      revision: "82afeb597ef397a7dea2a444b837ece0a6794c48"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.30.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e41675abdb0b01f1285ca999f63ac86f56a378a8efc54ab812ea978259739c33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df260a02380c34d41d9cb44bc736716e535a2ee247c7035e9d404d6746e2fe0a"
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
