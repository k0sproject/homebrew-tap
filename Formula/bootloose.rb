class Bootloose < Formula
  desc "Creates containers that look like virtual machines"
  homepage "https://github.com/k0sproject/bootloose"
  url "https://github.com/k0sproject/bootloose.git",
      tag:      "v0.9.1",
      revision: "2881820a231a6517e2a7b0c21ccaadf572c40b96"
  license "Apache-2.0"
  head "https://github.com/k0sproject/bootloose.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/bootloose-0.9.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "1858e2e791e4062c1f463e45f2fca3c282b4f86e8c6d020fdfc744d830339832"
    sha256 cellar: :any_skip_relocation, ventura:      "fe8dafb7e713b851c756e1fd9b12879d3e951bf7ac09bb3df044ea16900ae6fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a58f3a9066c735863835166134f1fcc0870693bc91e3496a2828cf7656d27ba1"
  end

  depends_on "go" => :build

  def install
    system "make", "bootloose", "TAG_NAME=v#{version}"
    bin.install "bootloose"
    prefix.install ["LICENSE", "NOTICE", "README.md"]

    generate_completions_from_executable(bin/"bootloose", "completion")
  end

  test do
    version_output = shell_output("#{bin}/bootloose version")
    assert_match "v#{version}", version_output
  end
end
