class Ralph < Formula
  desc "AI-powered development orchestration tool"
  homepage "https://github.com/zon/ralph"
  url "https://github.com/zon/ralph/archive/refs/tags/v28.5.5.tar.gz"
  sha256 "f539d97e680d0c4da1ae864f8088ca430289bb7b00a174aa6e2b7a96047c6423"
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
