class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.12.0",
      revision: "610682e3ad9bc633cb31135fe4da8d43bf6f07d8"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.12.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "98d9bc068d49b7c5ba53b43884aa566c12c4d0f6158dc73d0f41e6a835689478"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "63357eb93ba430789f00828200f1a5daab253e34b747ae12a093eb89db45710b"
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
