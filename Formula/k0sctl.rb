class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.12.4",
      revision: "2ee49ef6d0d684718003896a49ca3ea6b90a4631"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  depends_on "go@1.17" => :build

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
