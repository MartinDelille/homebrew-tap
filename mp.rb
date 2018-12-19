class Mp < Formula
  desc "mp is a command line video processing app for macOS"
  homepage "https://github.com/benoit-pereira-da-silva/mp"
  url "https://github.com/benoit-pereira-da-silva/mp"
  version "1.0"
  sha256 "8a6c58620493f24b82e4a56de14dd13cd896bb3a9b69394f5d51f3fac4ec0199"

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
