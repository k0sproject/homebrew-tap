class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.13.2",
      revision: "71160254031c64fb42d138e138e4d26f145575f0"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.13.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "6e19f3b63330446bc7c54189a76a87c36c958002a922f846e1e73338f8430d0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6d374710fe31b22ed182be809e96ad2dcc9912fe906f02b1f1d983c018e4325d"
  end

  depends_on "go@1.19" => :build

  def install
    system "make", "k0sctl", "TAG_NAME=v#{version}"
    bin.install "k0sctl"
    prefix.install_metafiles

    output = Utils.safe_popen_read(bin/"k0sctl", "completion", "-s", "bash")
    (bash_completion/"k0sctl").write output

    output = Utils.safe_popen_read(bin/"k0sctl", "completion", "-s", "zsh")
    (zsh_completion/"_k0sctl").write output

    output = Utils.safe_popen_read(bin/"k0sctl", "completion", "-s", "fish")
    (fish_completion/"k0sctl.fish").write output
  end

  test do
    version_output = shell_output(bin/"k0sctl version 2>&1")
    assert_match "version: v#{version}", version_output
    init_output = shell_output(bin/"k0sctl init root@10.0.0.1 2>&1")
    assert_match "address: 10.0.0.1", init_output
  end
end
