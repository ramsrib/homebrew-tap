cask "recall-app" do
  version "0.1.0"
  sha256 "6d1d3955b1b1b5415c403bf72ae0488dc2070161fad9486fd9f21d64047e8971"

  url "https://github.com/ramsrib/recall-app/releases/download/v#{version}/Recall-App-v#{version}-arm64.dmg"
  name "Recall App"
  desc "Browse, search, and read your Claude Code and Codex sessions"
  homepage "https://github.com/ramsrib/recall-app"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app is a front end for the recall CLI — it shells out to the `recall`
  # binary for everything, so without it the app has nothing to show. Ollama is
  # left to the recall formula's caveats rather than forced as a dependency (see
  # Formula/recall.rb for why).
  depends_on formula: "ramsrib/tap/recall"
  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Recall App.app"

  zap trash: [
    "~/Library/Application Support/io.github.ramsrib.recall",
    "~/Library/Caches/io.github.ramsrib.recall",
    "~/Library/Preferences/io.github.ramsrib.recall.plist",
    "~/Library/Saved Application State/io.github.ramsrib.recall.savedState",
  ]

  caveats <<~EOS
    Recall App drives the `recall` CLI, which was installed alongside it.

    recall needs Ollama running to index. If you don't have it, get Ollama.app
    from https://ollama.com (or `brew install ollama && brew services start ollama`),
    then:

      ollama pull qwen3-embedding:0.6b
      recall index

    You can also reindex from inside the app with ⌘⇧R.
  EOS
end
