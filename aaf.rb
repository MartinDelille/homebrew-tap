class Aaf < Formula
  desc "A cross-platform SDK for AAF. AAF is a metadata management system and file format for use in professional multimedia creation and authoring. "
  homepage "https://sourceforge.net/projects/aaf/"
  url "https://github.com/MartinDelille/aaf/archive/lylo1.tar.gz"
  sha256 "7cc487eafd78787909d5d35982438182b26f7073db675de3eff7f57b0073d893"

  depends_on "cmake" => :build
  depends_on :xcode => :build

  def install
    system "mkdir", "-p", "out/build"
    Dir.chdir("out/build")
    system "pwd"
    system "cmake", "../..", "-G", "Xcode","-DPLATFORM=clang7", "-DARCH=x86_64", *std_cmake_args
    system "cmake", "--build", "."
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test aaf`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
