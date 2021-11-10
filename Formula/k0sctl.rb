class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s kubernetes clusters"
  homepage "https://github.com/k0sproject/k0sctl"
  version "0.11.4"
  url "https://github.com/k0sproject/k0sctl.git", using: :git, tag: "v#{version}"
  sha256 ""
  license "Apache-2"

  depends_on "go@1.17" => :build

  def install
    system "make", "install", "PREFIX=#{prefix}"
    prefix.install_metafiles
  end

  test do
    assert_match "version: #{version}", shell_output("#{bin}/k0sctl", "version")
    asset_match "address: 10.0.0.1", shell_output("#{bin}/k0sctl", "init", "root@10.0.0.1")
  end
end
