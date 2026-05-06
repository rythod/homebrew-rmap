# homebrew-rmap

Private Homebrew tap for [RMAP](https://github.com/rythod/rmap).

## Install

One-time setup (a token is needed because the source repo is private):

```sh
gh auth login                                          # if you don't already have gh authenticated
echo 'export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)' >> ~/.zshrc
source ~/.zshrc
```

Then:

```sh
brew tap rythod/rmap
brew install --cask rmap
```

## Update

```sh
brew upgrade --cask rmap
```

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
