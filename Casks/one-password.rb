cask 'one-password' do
  version '1.0.0'
  sha256 '0f789498ca40163ffacca78d541ffc6204f7669def7722cf3f156ba575c365e9'

  url "https://cache.agilebits.com/dist/1P/op/pkg/v#{version}/op_darwin_amd64_v#{version}.pkg"
  name '1Password CLI'
  homepage 'https://support.1password.com/command-line-getting-started/'

  pkg "op_darwin_amd64_v#{version}.pkg"

  uninstall pkgutil: 'com.1password.op'
end
