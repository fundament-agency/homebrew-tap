cask "issuemon" do
  arch arm: "arm64", intel: "x64"

  version "0.3.1"
  sha256 arm:   "8095efc37d911a0bc631092802fcaa33dc46350f9bf8690fe9713c8596de86ea",
         intel: "d55b643d7b9ac0c5468e58737c951d97eabfbc8daf924d682b04b7c4aa8e4459"

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
