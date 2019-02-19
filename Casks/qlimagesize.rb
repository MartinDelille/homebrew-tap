cask 'qlimagesize' do
  version '1.6.1'
  sha256 'bdcb859844a868742c740c7fb39cdde7dff7992c8896ece9b6b5c88d2f0368ab'

  url "https://github.com/martindelille/qlimagesize/releases/download/#{version}/qlImageSize.qlgenerator.zip"
  appcast 'https://github.com/martindelille/qlimagesize/releases.atom'
  name 'qlImageSize'
  homepage 'https://github.com/Nyx0uf/qlImageSize'

  qlplugin 'qlImageSize.qlgenerator'
end
