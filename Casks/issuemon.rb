cask "issuemon" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "0705557da0f77f6acbd04c09583bdf6a395b93788bfb9faf95da2b33509d33b3",
         intel: "f21e0fccce4ba7a2cd5f29b803e4371bad551b77881b3ca64d27a384d51f9274"

  url "https://github.com/fundament-agency/issuemon/releases/download/v#{version}/issuemon-#{version}-#{arch}.zip"
  name "IssueMon"
  desc "Tracks Jira issues and reports what changed"
  homepage "https://github.com/fundament-agency/issuemon"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "IssueMon.app"

  # IssueMon is signed ad hoc and not notarized, so Gatekeeper would block it after
  # every install and upgrade. Remove the quarantine flag Homebrew sets on the app;
  # if that fails, the app stays installed and macOS asks once, as before.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/IssueMon.app"],
        must_succeed: false
  end

  zap trash: [
    "~/.issuemon",
    "~/Library/Application Support/IssueMon",
    "~/Library/Preferences/agency.fundament.issuemon.plist",
    "~/Library/Saved Application State/agency.fundament.issuemon.savedState",
  ]
end
