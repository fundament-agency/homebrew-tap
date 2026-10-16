cask "issuemon" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "0000000000000000000000000000000000000000000000000000000000000000",
         intel: "1111111111111111111111111111111111111111111111111111111111111111"

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

  zap trash: [
    "~/.issuemon",
    "~/Library/Application Support/IssueMon",
    "~/Library/Preferences/agency.fundament.issuemon.plist",
    "~/Library/Saved Application State/agency.fundament.issuemon.savedState",
  ]
end
