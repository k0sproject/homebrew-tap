class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  url "https://github.com/k0sproject/k0sctl.git", 
    tag: "v0.11.4", 
    revision: "3b2e58b0915c92a972995d3d5d738e81a00fce96"
  license "Apache-2"
  head "https://github.com/k0sproject/k0sctl.git", branch: "main"

  depends_on "go@1.17" => :build

  def install
    system "make", "install", "PREFIX=#{prefix}"
    prefix.install_metafiles
  end

  test do
    assert_match "version: v#{version}", shell_output("#{bin}/k0sctl", "version")
    asset_match "address: 10.0.0.1", shell_output("#{bin}/k0sctl", "init", "root@10.0.0.1")
  end
end
