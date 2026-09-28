class Ccmeter < Formula
  desc "Subscription and context-window usage meters for Claude Code and Codex"
  homepage "https://github.com/ramsrib/ccmeter"
  url "https://github.com/ramsrib/ccmeter/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "af1488999e08250342a0578968884f8b247fa11038cd067e29c78bffe22bf7f0"
  license "MIT"
  head "https://github.com/ramsrib/ccmeter.git", branch: "main"

  # The tools are TypeScript executed directly — no build step. node runs them
  # via type stripping (>= 22.18; brew's node is well past that). The installed
  # shims prefer bun when the user happens to have it, but node alone suffices,
  # so bun is deliberately not a dependency.
  depends_on "node"

  def install
    # bin/ and src/ must stay siblings: each shim resolves its script as
    # ../src/<name>.ts, following the symlink brew puts in bin/ first.
    libexec.install "bin", "src"
    bin.install_symlink libexec/"bin/ccmeter"
    bin.install_symlink libexec/"bin/ctxmeter"
  end

  def caveats
    <<~EOS
      ccmeter reads your Claude Code OAuth token from the macOS Keychain, so the
      first run may prompt for Keychain access. ctxmeter needs no credentials.
    EOS
  end

  test do
    assert_match "context-window usage", shell_output("#{bin}/ctxmeter --help")
    assert_match "subscription usage", shell_output("#{bin}/ccmeter --help")
  end
end
