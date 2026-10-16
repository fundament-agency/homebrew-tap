# Fundament Homebrew tap

Homebrew casks for apps by [Fundament](https://www.fundament.agency/).

## IssueMon

Desktop app that keeps an eye on Jira issues and tells you what changed. Source and documentation: <https://github.com/fundament-agency/issuemon>.

```sh
brew install --cask fundament-agency/tap/issuemon
```

That command taps this repository and trusts the `issuemon` cask in one step (Homebrew 6 and later require explicit trust for third-party taps). If you prefer the two-step form:

```sh
brew tap fundament-agency/tap
brew trust --cask fundament-agency/tap/issuemon
brew install --cask issuemon
```

**First launch.** IssueMon is signed ad hoc and not notarized by Apple, so macOS would block it after every install and upgrade. The cask removes the quarantine flag from the app after installing it, so IssueMon opens straight away. `brew upgrade` may warn that the signer changed and macOS may prompt: an ad-hoc signature changes with every build, and the flag is already gone. If macOS does block it, open **System Settings → Privacy & Security**, click **Open Anyway** next to "IssueMon was blocked…" and confirm, or run `xattr -dr com.apple.quarantine /Applications/IssueMon.app`.

Upgrade, uninstall, and uninstall including your data and API token:

```sh
brew upgrade --cask issuemon
brew uninstall --cask issuemon
brew uninstall --zap --cask issuemon
```

## Maintenance

- The cask in `Casks/issuemon.rb` is rewritten by the `update-cask` workflow in the app repository every time a GitHub release is published there: version and both `sha256` values. Do not edit those by hand unless the workflow failed.
- The workflow pushes with a write-enabled deploy key of this repository; its private half is the `TAP_DEPLOY_KEY` secret in the app repository.
- Until the first release is published, the checksums are placeholders and the cask cannot be installed.
- Check a change locally with `brew style --fix --cask fundament-agency/tap/issuemon` and `brew audit --cask --online fundament-agency/tap/issuemon`, then run `brew developer off`.
