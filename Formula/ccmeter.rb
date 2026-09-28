class Ccmeter < Formula
  desc "Subscription usage, context-window and spend-attribution tools for Claude Code and Codex"
  homepage "https://github.com/ramsrib/ccmeter"
  url "https://github.com/ramsrib/ccmeter/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "cb2160e5b680011a44d3aad35cc8cc030a4f21bf58c239c328f4600974b06642"
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
    bin.install_symlink libexec/"bin/ccburn"
  end

  def caveats
    <<~EOS
      ccmeter reads your Claude Code OAuth token from the macOS Keychain, so the
      first run may prompt for Keychain access. Each run appends its readings to
      ~/.local/state/ccmeter/history.jsonl (CCMETER_NO_HISTORY=1 turns it off),
      which ccburn reads. ctxmeter and ccburn need no credentials.
    EOS
  end

  test do
    assert_match "context-window usage", shell_output("#{bin}/ctxmeter --help")
    assert_match "subscription usage", shell_output("#{bin}/ccmeter --help")
    assert_match "usage went", shell_output("#{bin}/ccburn --help")
  end
end
