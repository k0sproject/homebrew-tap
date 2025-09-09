class Bootloose < Formula
  desc "Creates containers that look like virtual machines"
  homepage "https://github.com/k0sproject/bootloose"
  url "https://github.com/k0sproject/bootloose.git",
      tag:      "v0.9.4",
      revision: "f19afdf73a44863966e89c60a6568d4e566f4b68"
  license "Apache-2.0"
  head "https://github.com/k0sproject/bootloose.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/bootloose-0.9.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "7d6f22258b41a8d591488e8bdda55ac8e3d64cdc16a4ed042ea9a66c08e02a2b"
    sha256 cellar: :any_skip_relocation, ventura:      "f1a3bafa708ce87a12479562210faa78845d179b527b544fcea4f5fcd14d9afb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e8bb1527ae2a09b33016bb90045c4d5d8c57a08f30e04a57e568541f69c4e645"
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
