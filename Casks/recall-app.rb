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
  # binary for everything. Without it the app has nothing to show, so this is a
  # hard dependency. recall in turn pulls in ollama.
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
    Before first use, start Ollama, pull the embedding model, and index:

      brew services start ollama
      ollama pull qwen3-embedding:0.6b
      recall index

    You can also reindex from inside the app with ⌘⇧R.
  EOS
end
