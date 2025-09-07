cask 'hummingbird' do
  version '3.3.0'
  sha256 '889159ea1683b2666bc3bd7c87d10a2837bf46e289f6eedf7135d1e92b6b86d6'

  url "https://github.com/twio142/hummingbird/releases/download/v#{version}/Hummingbird-#{version}.zip"
  name 'Hummingbird'
  homepage 'https://github.com/twio142/hummingbird'

  app 'Hummingbird.app'
end
