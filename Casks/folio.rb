cask "folio" do
  version "0.5.0"
  sha256 "d5038e3c2bec278014c252530af8a60987e6fc2530e7e3dd7ea05855707064f9"

  url "https://github.com/ramsrib/folio/releases/download/v#{version}/Folio-v#{version}-arm64.dmg"
  name "Folio"
  desc "Read-optimized, files-on-disk Markdown notes reader"
  homepage "https://github.com/ramsrib/folio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

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

    It is early software: macOS is the built target, and the tests cover the
    parser and the store rather than the UI. See the repo's Limitations section
    before trusting it with a vault you cannot afford to lose.
  EOS
end
