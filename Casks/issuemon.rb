cask "issuemon" do
  arch arm: "arm64", intel: "x64"

  version "0.1.3"
  sha256 arm:   "2111bf5427b6563009862e98f6cb7c5f1a9d220573747fb5aaeaf91601164cfa",
         intel: "f49ed380408681318655da6a2e7717fea8d3516f61b327e19511e099fec83274"

  url "https://github.com/fundament-agency/issuemon/releases/download/v#{version}/issuemon-#{version}-#{arch}.tar.xz"
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
