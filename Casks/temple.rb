cask "temple" do
  version "0.1.9"
  sha256 "0855498ea835ab6cb9feeb6f5a6667363dda1da5d8ab8931a023790e70f48c25"

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

  zap trash: [
    "~/Library/Application Support/Temple",
    "~/Library/Caches/com.sriramb.temple",
    "~/Library/Preferences/com.sriramb.temple.plist",
    "~/Library/Saved Application State/com.sriramb.temple.savedState",
  ]
end
