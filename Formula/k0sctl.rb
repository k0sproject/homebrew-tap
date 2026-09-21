class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.33.1",
      revision: "c4bfa9541ca05edd8a2d143fd50290fbc9243d0b"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.33.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "916c0dafbd61dbb9f3bfec5363d8068125160c7b9f6c788b8d9ce47820699ffd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1187286df166f18c5107ca5fc4a79fa24dfe0f3c563a4c99cef82d0cff3d081f"
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
