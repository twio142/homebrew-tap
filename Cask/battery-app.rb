cask "battery-app" do
  version "1.2.3"
  sha256 "e0a528db9d170a5b8d3e0feff01b12170b8a9fb5fd983054d505d864e081ba2d"

  url "https://github.com/twio142/battery/releases/download/v#{version}/battery-arm64.dmg"
  name "Battery"
  desc "App for managing battery charging. (Also installs a CLI on first use.)"
  homepage "https://github.com/twio142/battery/"

  auto_updates true
  depends_on macos: ">= :catalina"
  depends_on arch: :arm64

  app "battery.app"

  uninstall delete: "/usr/local/bin/smc"

  zap trash: [
    "~/.config/battery",
    "~/Library/Application Support/battery",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/co.palokaj.battery.sfl*",
    "~/Library/Caches/co.palokaj.battery",
    "~/Library/Caches/co.palokaj.battery.ShipIt",
    "~/Library/HTTPStorages/co.palokaj.battery",
    "~/Library/LaunchAgents/battery.plist",
    "~/Library/Preferences/co.palokaj.battery.plist",
    "~/Library/Preferences/org.mentor.Battery.plist",
    "~/Library/Saved Application State/co.palokaj.battery.savedState",
  ]
end
