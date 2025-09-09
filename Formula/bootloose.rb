class Bootloose < Formula
  desc "Creates containers that look like virtual machines"
  homepage "https://github.com/k0sproject/bootloose"
  url "https://github.com/k0sproject/bootloose.git",
      tag:      "v0.9.4",
      revision: "f19afdf73a44863966e89c60a6568d4e566f4b68"
  license "Apache-2.0"
  head "https://github.com/k0sproject/bootloose.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/bootloose-0.9.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "559a53b18409541fec89c56d4389415e2fc40c42d2d9fc4d13e7077ef145117e"
    sha256 cellar: :any_skip_relocation, ventura:      "d5c382bc3f870350f6cee358df373d1e7ce384ce834da22220febbafa44dbad7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1ee7429025253068828f8c74d9768f5490c8644b129e7860b3ed053349ade39e"
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
