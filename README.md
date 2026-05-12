# RMAP

Relational Map Analysis Protocol — a diagramming editor derived from Relational Frame Theory for visualizing human language and cognition.

## Install

Open Terminal and paste this:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/rythod/homebrew-rmap/main/install.sh)"
```

That's it. The installer sets up [Homebrew](https://brew.sh) (if you don't already have it), then installs the RMAP app and its `rmap` command-line tool. You'll be asked for your Mac password once during the Homebrew setup step.

After it finishes:
- Launch **RMAP** from Applications, Spotlight, or Launchpad.
- Open a **new** Terminal window and type `rmap` to use the CLI.

## Already have Homebrew?

If you'd rather skip the installer script:

```sh
brew tap rythod/rmap
brew install --cask rmap
```

## Update

```sh
brew upgrade --cask rmap
```

## Uninstall

```sh
brew uninstall --cask rmap
brew untap rythod/rmap
```

Add `--zap` to the uninstall to also remove RMAP's preferences and caches.

## Auto-update (optional)

Drop this LaunchAgent to check weekly:

```xml
<!-- ~/Library/LaunchAgents/com.rythod.brew-upgrade-rmap.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.rythod.brew-upgrade-rmap</string>
  <key>ProgramArguments</key>
  <array>
    <string>/opt/homebrew/bin/brew</string>
    <string>upgrade</string>
    <string>--cask</string>
    <string>rmap</string>
  </array>
  <key>StartInterval</key><integer>604800</integer>
  <key>RunAtLoad</key><true/>
</dict>
</plist>
```

Load with `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.rythod.brew-upgrade-rmap.plist`.
