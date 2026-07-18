cask "folio" do
  version "0.2.0"
  sha256 "b5842005ae0881d50f300d0246cf0877779616637f6e549b32d9411f7192220f"

  url "https://github.com/ramsrib/folio/releases/download/v#{version}/Folio-v#{version}-arm64.dmg"
  name "Folio"
  desc "Read-optimized, files-on-disk Markdown notes reader"
  homepage "https://github.com/ramsrib/folio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :tahoe"

  app "Folio.app"

  zap trash: [
    "~/Library/Application Support/com.sriramb.folio",
    "~/Library/Caches/com.sriramb.folio",
    "~/Library/Preferences/com.sriramb.folio.plist",
    "~/Library/Saved Application State/com.sriramb.folio.savedState",
  ]

  caveats <<~EOS
    Folio opens a folder of Markdown files as a vault — your files stay where
    they are, on disk, and Folio never moves or rewrites them behind your back.

    It is early software: macOS is the built target, and there is no test suite
    yet. See the repo's Limitations section before trusting it with a vault you
    cannot afford to lose.
  EOS
end
