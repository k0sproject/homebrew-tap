class Bootloose < Formula
  desc "Creates containers that look like virtual machines"
  homepage "https://github.com/k0sproject/bootloose"
  url "https://github.com/k0sproject/bootloose.git",
      tag:      "v0.7.2",
      revision: "bd4e26304abc6908bba1515295dbd42129b47c4d"
  license "Apache-2.0"
  head "https://github.com/k0sproject/bootloose.git", branch: "main"

  bottle do
    root_url "https://github.com/k0sproject/homebrew-tap/releases/download/bootloose-0.7.1"
    sha256 cellar: :any_skip_relocation, ventura:      "f0cd7b933366eb52423c5f95001a688014353b176e7626a8786626ff9607c2ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1a6bb3d91c40151c08360f28879e3e65afb22dac4e0d423a672298b354af7f1f"
  end

  depends_on "go" => :build

  def install
    system "make", "bootloose", "TAG_NAME=v#{version}"
    bin.install "bootloose"
    prefix.install ["LICENSE", "NOTICE", "README.md"]

    generate_completions_from_executable(bin/"bootloose", "completion")
  end

  test do
    version_output = shell_output(bin/"bootloose version 2>&1")
    assert_match "v#{version}", version_output
  end
end
