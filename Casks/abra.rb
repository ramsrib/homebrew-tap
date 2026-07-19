cask "abra" do
  version "0.2.2"
  sha256 "536526c96c559728d3e149618119fe2ecef67117b1ac3c82dfe09b126fbcc3b0"

  url "https://github.com/ramsrib/abra/releases/download/v#{version}/Abra-#{version}-darwin-arm64.zip"
  name "abra"
  desc "Local push-to-talk dictation — hold Fn, speak, release"
  homepage "https://github.com/ramsrib/abra"

  depends_on macos: :ventura
  depends_on arch: :arm64
  depends_on formula: "uv"
  depends_on formula: "ffmpeg"

  app "Abra.app"

  postflight do
    engine = File.expand_path("~/.abra/engine")
    # The engine is pinned to this release's tag — never a moving branch, so
    # a broken main can't affect installs or upgrades.
    if File.exist?(File.join(engine, "pyproject.toml"))
      refresh = "cd #{engine} && " \
                "(/usr/bin/git fetch --depth 1 origin tag v#{version} && " \
                "/usr/bin/git checkout -q v#{version} && " \
                "#{HOMEBREW_PREFIX}/bin/uv sync) || true"
      system_command "/bin/sh",
                     args:         ["-c", refresh],
                     print_stderr: false
    else
      system_command "/usr/bin/git",
                     args:         ["clone", "--depth", "1", "--branch", "v#{version}",
                                    "https://github.com/ramsrib/abra", engine],
                     print_stderr: false
      system_command "/bin/sh",
                     args:         ["-c", "cd #{engine} && #{HOMEBREW_PREFIX}/bin/uv sync"],
                     print_stderr: false
    end
  end

  zap trash: "~/.abra"

  caveats <<~EOS
    First launch downloads the speech model (~700MB) — the menu bar icon
    shows an hourglass while it loads.

    The engine lives in ~/.abra/engine, pinned to this release's tag and
    updated automatically on brew upgrade.
  EOS
end
