class Qmlfmt < Formula
  desc "Command line application that formats QML files"
  homepage "https://github.com/jesperhh/qmlfmt"
  version "1.0.85"
  url "https://github.com/jesperhh/qmlfmt/archive/#{version}.tar.gz"
  sha256 "c78a79781f2499ffeadacfa3beea7752f8b7e511c45d163007aca73fbd066b2e"
  depends_on "cmake" => :build
  depends_on "qt" => :build

  resource "qt-creator" do
    url "https://github.com/qt-creator/qt-creator.git",
        :revision => "e8df914e"
  end

  def install
    resources.each do |res|
      res.stage(buildpath/res.name)
    end
    system "cmake", ".", *std_cmake_args
    system "make"
    bin.install "qmlfmt"
  end

  test do
    (testpath/"test.qml").write <<~EOS
      import QtQuick 2.5
      import QtQuick.Window 2.2
      import    "qrc:/test/"

      Window {
          visible: true

          MouseArea {
              anchors.fill: parent
              onClicked: {
                  Qt.quit();
              }
          }

          Test {

          }

          Text {
              text: qsTr("Hello World")
              anchors.centerIn: parent
          }
      }
    EOS
    expected = <<~EOS
      import QtQuick 2.5
      import QtQuick.Window 2.2
      import "qrc:/test/"

      Window {
          visible: true

          MouseArea {
              anchors.fill: parent
              onClicked: {
                  Qt.quit()
              }
          }

          Test {
          }

          Text {
              text: qsTr("Hello World")
              anchors.centerIn: parent
          }
      }
    EOS

    system "#{bin}/qmlfmt", "-w", "test.qml"
    assert_equal expected, File.read("#{testpath}/test.qml")
  end
end
