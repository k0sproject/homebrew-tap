class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.25.1",
      revision: "f797b609f6b016a59cb81940f2458038879a3e72"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.25.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "166059f76d92ea5b16e7a3c78a58f11aecb6fbdfbea0bad244562e0832ae2121"
    sha256 cellar: :any_skip_relocation, ventura:      "24e3a214285c47469b98ae309c0c397cb6c4b183bfad3be5f5ff28a2685b8567"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8fcd9b5ff603433caa0c4bb23bc8b99f26c63a582729b532fccba16ac15f2af6"
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
