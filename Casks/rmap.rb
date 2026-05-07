cask "rmap" do
  version "0.1.0"
  sha256 "41301661bbcec2c9fc89b7adb7d79038cd7ce2f82ee29ccfe501b1aa56a0643d"

  # Asset ID changes per release. Updated by scripts/bump-cask.sh in rythod/rmap.
  asset_id = "413182524"

  url "https://api.github.com/repos/rythod/rmap/releases/assets/#{asset_id}",
      verified: "api.github.com/repos/rythod/rmap/",
      header: [
        "Accept: application/octet-stream",
        "Authorization: Bearer #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", "")}",
      ]
  name "RMAP"
  desc "Relational Map Analysis Protocol — RFT-derived diagramming editor"
  homepage "https://github.com/rythod/rmap"

  depends_on macos: ">= :catalina"

  app "RMAP.app"

  # The build is unsigned, so macOS quarantines it on first launch and shows
  # the "Apple could not verify RMAP is free of malware" dialog with no
  # "Open Anyway" button on macOS 14+. Stripping com.apple.quarantine after
  # install tells Gatekeeper to skip verification.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/RMAP.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.rmap.editor",
    "~/Library/Caches/com.rmap.editor",
    "~/Library/Preferences/com.rmap.editor.plist",
    "~/Library/Saved Application State/com.rmap.editor.savedState",
  ]
end
