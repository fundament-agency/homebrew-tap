cask "issuemon" do
  arch arm: "arm64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "14e9d4537db45429a1bcce8a15cc92e2a5af3a792439a953974dbdd1e2ac8ebf",
         intel: "c1381cb8767a44ccfc6f18ba3da32639da119c2b5b0352d28497bee3061e81a4"

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
