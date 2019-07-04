# Patches for Qt must be at the very least submitted to Qt's Gerrit codereview
# rather than their bug-report Jira. The latter is rarely reviewed by Qt.
class QtAT56 < Formula
  desc "Cross-platform application and UI framework"
  homepage "https://www.qt.io/"
  url "https://download.qt.io/archive/qt/5.6/5.6.3/single/qt-everywhere-opensource-src-5.6.3.tar.xz"
  mirror "https://qt.mirror.constant.com/archive/qt/5.6/5.6.3/single/qt-everywhere-opensource-src-5.6.3.tar.xz"
  sha256 "2fa0cf2e5e8841b29a4be62062c1a65c4f6f2cf1beaf61a5fd661f520cd776d0"

  keg_only "Qt 5 has CMake issues when linked"

  depends_on "pkg-config" => :build
  depends_on :xcode => :build
  depends_on :macos => :sierra

  # From https://bugreports.qt.io/browse/QTBUG-62266?focusedCommentId=371972#comment-371972
  patch do
    url "https://raw.githubusercontent.com/MartinDelille/homebrew-tap/master/qt563.patch"
    sha256 "c7dc404553fd061e0e9bdbf21b7b2efeb28d3d48021da5ab8e7f22699afb3ec2"
  end

  def install
    args = %W[
      -verbose
      -prefix #{prefix}
      -release
      -opensource -confirm-license
      -nomake examples
      -nomake tests
    ]

    system "./configure", *args
    system "make"
    ENV.deparallelize
    system "make", "install"

    # Some config scripts will only find Qt in a "Frameworks" folder
    frameworks.install_symlink Dir["#{lib}/*.framework"]

    # The pkg-config files installed suggest that headers can be found in the
    # `include` directory. Make this so by creating symlinks from `include` to
    # the Frameworks' Headers folders.
    Pathname.glob("#{lib}/*.framework/Headers") do |path|
      include.install_symlink path => path.parent.basename(".framework")
    end

    # Move `*.app` bundles into `libexec` to expose them to `brew linkapps` and
    # because we don't like having them in `bin`.
    # (Note: This move breaks invocation of Assistant via the Help menu
    # of both Designer and Linguist as that relies on Assistant being in `bin`.)
    libexec.mkpath
    Pathname.glob("#{bin}/*.app") { |app| mv app, libexec }
  end

  def caveats; <<~EOS
    We agreed to the Qt open source license for you.
    If this is unacceptable you should uninstall.
  EOS
  end

  test do
    (testpath/"hello.pro").write <<~EOS
      QT       += core
      QT       -= gui
      TARGET = hello
      CONFIG   += console
      CONFIG   -= app_bundle
      TEMPLATE = app
      SOURCES += main.cpp
    EOS

    (testpath/"main.cpp").write <<~EOS
      #include <QCoreApplication>
      #include <QDebug>

      int main(int argc, char *argv[])
      {
        QCoreApplication a(argc, argv);
        qDebug() << "Hello World!";
        return 0;
      }
    EOS

    system bin/"qmake", testpath/"hello.pro"
    system "make"
    assert_predicate testpath/"hello", :exist?
    assert_predicate testpath/"main.o", :exist?
    system "./hello"
  end
end
