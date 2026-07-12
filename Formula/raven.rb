class Raven < Formula
  desc "Terminal dashboard for your local Claude Code sessions"
  homepage "https://github.com/ramsrib/raven"
  version "0.1.0"
  license "MIT"

  # raven shells out to open/pbcopy/osascript/lsappinfo — macOS only.
  depends_on :macos

  on_arm do
    url "https://github.com/ramsrib/raven/releases/download/v#{version}/raven_#{version}_darwin_arm64.tar.gz"
    sha256 "91f927511580a3284e0e568e51d7822798fd31adfa0556266f841bf7e4b99755"
  end
  on_intel do
    url "https://github.com/ramsrib/raven/releases/download/v#{version}/raven_#{version}_darwin_amd64.tar.gz"
    sha256 "b9e43063b349fbde53fd8f278a01e8e27b7456ba4eaf7861b69d7038a81e4dd5"
  end

  livecheck do
    url "https://github.com/ramsrib/raven/releases/latest"
    strategy :github_latest
  end

  def install
    bin.install "raven"
  end

  def caveats
    <<~EOS
      raven is an interactive TUI — run it in a terminal:

        raven

      It watches the Claude Code sessions already running on this machine, so
      start a session first or the dashboard will be empty. Press ? for keys.

      Monitoring is read-only, but `x` sends SIGTERM to a live Claude Code
      process. It asks first — but confirming a kill can still lose in-flight work.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/raven --version")
  end
end
