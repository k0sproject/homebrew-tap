class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.11.4",
      revision: "3b2e58b0915c92a972995d3d5d738e81a00fce96"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.11.4"
    sha256 cellar: :any_skip_relocation, catalina:     "1c8806321726c1a854acc80b89e34d0351de6482624c39848236ca5474f7ca4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "22deb72e675bab325f1802321baaf6e7c2a7ac5662534947560b4106a8b62f78"
  end

  depends_on "go@1.17" => :build

  def install
    system "make", "k0sctl", "TAG_NAME=v#{version}"
    bin.install "k0sctl"
    prefix.install_metafiles
  end

  test do
    version_output = shell_output(bin/"k0sctl version 2>&1")
    assert_match "version: v#{version}", version_output
    init_output = shell_output(bin/"k0sctl init root@10.0.0.1 2>&1")
    assert_match "address: 10.0.0.1", init_output
  end
end
