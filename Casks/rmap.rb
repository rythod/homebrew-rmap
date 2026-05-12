cask "rmap" do
  version "0.1.1"
  sha256 "94addd5e1ba3759258966c88ee7b7e1bea4ec4ffc75eeeb8f1922b89fc5821a1"

  url "https://github.com/rythod/homebrew-rmap/releases/download/v#{version}/RMAP_#{version}_universal.dmg"
  name "RMAP"
  desc "Relational Map Analysis Protocol — RFT-derived diagramming editor"
  homepage "https://github.com/rythod/homebrew-rmap"

  depends_on macos: ">= :catalina"

  app "RMAP.app"

  # Symlink the CLI binary bundled inside RMAP.app onto Homebrew's bin prefix
  # so users can run `rmap` from any new terminal with no PATH setup.
  binary "#{appdir}/RMAP.app/Contents/Resources/rmap"

  # The release build is unsigned (no Apple Developer Program). Two macOS
  # privacy systems intercept it on first launch:
  #
  #   1. Gatekeeper blocks unsigned/quarantined apps with a "could not verify
  #      malware" dialog that has no "Open Anyway" button on macOS 14+.
  #      Stripping com.apple.quarantine bypasses this.
  #   2. TCC (Privacy & Security consent) needs a stable code-signing identity
  #      to remember an "Allow" decision. The linker-only ad-hoc signature
  #      that ships in the bundle has identifier "rmap_app-<random>", so
  #      TCC sees each launch as a different app and re-prompts forever.
  #      A full ad-hoc bundle re-sign produces identifier "com.rmap.editor"
  #      (from Info.plist), binds Info.plist into the signature, and seals
  #      resources — giving TCC a persistent identity.
  postflight do
    system_command "/usr/bin/xattr",
                   args:  ["-cr", "#{appdir}/RMAP.app"],
                   sudo:  false
    system_command "/usr/bin/codesign",
                   args:  ["--force", "--deep", "--sign", "-",
                           "#{appdir}/RMAP.app"],
                   sudo:  false
  end

  zap trash: [
    "~/Library/Application Support/com.rmap.editor",
    "~/Library/Caches/com.rmap.editor",
    "~/Library/Preferences/com.rmap.editor.plist",
    "~/Library/Saved Application State/com.rmap.editor.savedState",
  ]
end
