cask "tarp" do
  version "0.1.0"
  sha256 "ca6e6a7c3620996af679bdcd6bb8b0919f88b5ff2c689dbc2921602146895d9b"

  url "https://github.com/ramsrib/tarp/releases/download/v#{version}/Tarp-macos-arm64.dmg"
  name "Tarp"
  desc "Plain, privacy-first terminal"
  homepage "https://github.com/ramsrib/tarp"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Tarp.app"

  zap trash: [
    "~/.tarp",
    "~/Library/Application Support/dev.tarp.Tarp",
    "~/Library/Caches/dev.tarp.Tarp",
    "~/Library/Preferences/dev.tarp.Tarp.plist",
    "~/Library/Saved Application State/dev.tarp.Tarp.savedState",
  ]
end
