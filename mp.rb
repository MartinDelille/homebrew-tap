class Mp < Formula
  desc "mp is a command line video processing app for macOS"
  homepage "https://github.com/benoit-pereira-da-silva/mp"
  url "https://github.com/benoit-pereira-da-silva/mp/archive/v1.0.1.tar.gz"
  sha256 "b471b83c650a19989b5682ba4fc06b19c5c2b0ff5ee06492a2e314f50180ec57"

  def install
    system "swift", "build",
                          "-c",
                          "release",
                          "-Xswiftc",
                          "-static-stdlib"
    prefix.bin "./.build/x86_64-apple-macosx10.10/release/mp"
  end

  test do
    system "mp", "help"
  end
end
