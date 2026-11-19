class Ralph < Formula
  desc "AI-powered development orchestration tool"
  homepage "https://github.com/zon/ralph"
  url "https://github.com/zon/ralph/archive/refs/tags/v29.0.58.tar.gz"
  sha256 "7b16d27dc50287e470d95ff3c863863c43671713e72399c4f45897e5318e9ee8"
  license "GPL-3.0-only"

  depends_on "go" => :build

  depends_on "anomalyco/tap/opencode"
  depends_on "argoproj/tap/argo"
  depends_on "gh"
  depends_on "git"
  depends_on "kubernetes-cli"

  def install
    system "go", "build", *std_go_args, "./cmd/ralph"
  end

  def caveats
    <<~EOS
      Homebrew resolves ralph's dependencies only from taps it already has. Tap the
      repositories that provide opencode and the Argo CLI before installing:

        brew tap anomalyco/tap
        brew tap argoproj/tap

      Then authenticate GitHub and OpenCode so ralph can run:

        gh auth login
        opencode auth
    EOS
  end

  test do
    assert_match(/\d+\.\d+\.\d+/, shell_output("#{bin}/ralph --version"))
  end
end
