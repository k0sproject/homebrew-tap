class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.12.2",
      revision: "ab868a932d8faabfea5c431cf92c7ca1cf0c1fd1"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.12.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "88adc699d746f9686441cd495bafdb7aa45cd417ee487ba7422c8fc14cbc330b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ac81db4c3b10d38f8dd5d0bef0e53538f6d8b1b84bf109b7cd1a54ef0f84d064"
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
