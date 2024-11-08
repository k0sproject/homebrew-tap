class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.19.3",
      revision: "3d735a22a6dcb934c8a62cf6a3d6ef003134cccb"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.19.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c67fee691722b905c434e50903babda7042d65f37acebf0515b22dd135a4e596"
    sha256 cellar: :any_skip_relocation, ventura:      "733ebad2c8cc8ea9896486b012b45bef4b08a56c3850bd29e2be24b2855b7d9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f886ca578a727e740198c1722a9bbbf8498ae687aeb19a0f1367808999759cbd"
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
