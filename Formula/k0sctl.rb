class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.29.0",
      revision: "48ad3a597ebe6ab27e8fa0872a222ca72cbc030c"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.29.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b9f4f66dac17569ee675780aabfb3d05b85741688040d5bb82494d0c32861dc7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66ec4a53b6302fff6f2b1384edb00b30ad6560bd1e0d567e70ee499dbd782c4c"
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
