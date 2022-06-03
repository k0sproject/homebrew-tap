class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git",
      tag:      "v0.13.0",
      revision: "9e46423832d65976141ca5e95a92eb07aef5d288"
  license "Apache-2.0"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/k0sctl-0.13.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "3b9d9128a902675452f90571495070c6c453ae9b4383afc9b47ec877e408a7bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "313ce3832a513ca5bdd22a6bb46903e9ddbef55775c24a41f6c9a7622ddef3ce"
  end

  depends_on "go@1.18" => :build

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
