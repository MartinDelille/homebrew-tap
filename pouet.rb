class Pouet < Formula
  desc "A basic command line application written with Qt"
  homepage "https://github.com/MartinDelille/pouet"
  url "https://github.com/MartinDelille/pouet/archive/0.2.tar.gz"
  sha256 "ffdb029ada6d03fe3fa323577693cc233ef3d2300784a8d79077cecf6df7a470"
  depends_on "qt" => :build
  depends_on "libsndfile"

  def install
    system "qmake", "pouet.pro"
    system "make"
    bin.install "pouet"
  end

  test do
    system "#{bin}/pouet", "--version"
  end
end
