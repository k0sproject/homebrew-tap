class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.33.0",
      revision: "2c1aef3f3733e6d76eebc95346e627b0026ac344"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.33.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c0a9a7d9e8982b3f3055ef971beaf2e652382063aec3f9e9f4a8b0a82fa6ac84"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6023599c5adc03d4d46f4545bb660d0eafc4220d455f9592685b8e5db64b5422"
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
