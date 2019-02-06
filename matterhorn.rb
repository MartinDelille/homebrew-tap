class Matterhorn < Formula
  desc "Unix terminal client for the Mattermost chat system"
  homepage "https://github.com/matterhorn-chat/matterhorn"
  url "https://github.com/matterhorn-chat/matterhorn.git", :tag => "50200.1.1"

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    system "cabal", "new-update"
    system "cabal", "install", "tasty-quickcheck"
    system "./build.sh"
    bin.install "dist-newstyle/build/x86_64-osx/ghc-8.4.4/matterhorn-50200.1.1/x/matterhorn/build/matterhorn/matterhorn"
  end

  test do
    system "#{bin}matterhorn", "--version"
  end
end
