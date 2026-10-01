class Ralph < Formula
  desc "AI-powered development orchestration tool"
  homepage "https://github.com/zon/ralph"
  url "https://github.com/zon/ralph/archive/refs/tags/v28.3.1.tar.gz"
  sha256 "cde1fe73fc30e86582985e79aef149f5fa9eab16295356e94e17b735187e7136"
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
