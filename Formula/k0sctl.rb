class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.32.1",
      revision: "db3dfb711f8b95e6f3bf4297db60dd5fbd337f85"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.32.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d5ecd0afd53562535f33219b25710ca157c3f37e07e941302fadc5cd1ac5c6e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "84e8e60ab73e246c0ad8015420ed8701fd61b2e82f12372e7d9032c2ed970f09"
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
