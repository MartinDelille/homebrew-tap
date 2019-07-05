class Aaf < Formula
  desc "A cross-platform SDK for AAF."
  homepage "https://sourceforge.net/projects/aaf/"
  url "https://github.com/MartinDelille/aaf/archive/lylo1.tar.gz"
  sha256 "7cc487eafd78787909d5d35982438182b26f7073db675de3eff7f57b0073d893"

  depends_on "cmake" => :build
  depends_on :xcode => :build

  def install
    mkdir "out" do
      mkdir "build" do
        system "cmake", "../..", "-G", "Xcode","-DPLATFORM=clang7", "-DARCH=x86_64", *std_cmake_args
        system "cmake", "--build", "."
      end
      include.install Dir["shared/include/*"]
      lib.install Dir["target/clang7-x86_64/Debug/RefImpl/*"]
    end
  end

  test do
    (testpath/"main.cpp").write <<~EOS
      #include <AAF.h>
      #include <AAFResult.h>

      int main() {
        HRESULT hr = AAFLoad(nullptr);

        if (AAFRESULT_SUCCEEDED(hr)) {
          return 0;
        } else {
          return -1;
        }
      }
    EOS

    system ENV.cxx, "-I#{include}", "-L#{lib}", "-laaflib", testpath/"main.cpp", "-o", testpath/"aaf-test"
    assert_predicate testpath/"aaf-test", :exist?
    system "./aaf-test"
  end
end
