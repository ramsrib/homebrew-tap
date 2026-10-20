cask "temple" do
  version "0.6.1"
  sha256 "8b48348d2f749f43ec3a4443b31601b1544ae1fc4dedd159a0e1b893f5d7ddbe"

  url "https://github.com/ramsrib/temple/releases/download/v#{version}/Temple-v#{version}-arm64.dmg"
  name "Temple"
  desc "IDE for your Claude Code and Codex agents"
  homepage "https://github.com/ramsrib/temple"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Temple.app"
  binary "#{appdir}/Temple.app/Contents/Helpers/temple"

  zap trash: [
    "~/Library/Application Support/Temple",
    "~/Library/Caches/com.sriramb.temple",
    "~/Library/Preferences/com.sriramb.temple.plist",
    "~/Library/Saved Application State/com.sriramb.temple.savedState",
  ]
end
