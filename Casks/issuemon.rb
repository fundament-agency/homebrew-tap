cask "issuemon" do
  arch arm: "arm64", intel: "x64"

  version "0.1.1"
  sha256 arm:   "8f1390582ca5fbd9584c8ae96943b2e234b2dce711b0d4d07472eb54b2a5be1d",
         intel: "dabc9e8bd20d81cc89f5c3ca13b5a06b8aba69848bbc89c60f038dadb55edd39"

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
