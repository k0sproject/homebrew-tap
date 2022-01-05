class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.12.1",
      revision: "79d76aa6d40b1ae857f3606353bbb63186ff2085"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.12.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "ae2ea945ed73dca9bfec628024852ae73e37c050a6c8e7fb3eb3ff687ed9ceca"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0e4a3d35d1004679627d6c50481e5e37bde87d36f61e38e3ad09ffe170f4d2bb"
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
