class RmapCli < Formula
  desc "Command-line interface for the RMAP editor"
  homepage "https://github.com/rythod/rmap"
  url "https://github.com/rythod/rmap.git",
      tag:      "v0.1.0",
      revision: "a3d7e92449ad440f5cfc38fade00409e46c80624"
  version "0.1.0"
  license "Proprietary"

  depends_on "rust" => :build

  def install
    cd "app/cli" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match "RMAP editor CLI", shell_output("#{bin}/rmap --help")
  end
end
