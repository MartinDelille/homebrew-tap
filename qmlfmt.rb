class Qmlfmt < Formula
  desc "Command line application that formats QML files"
  homepage "https://github.com/jesperhh/qmlfmt"
  version "1.1.2"
  url "https://github.com/jesperhh/qmlfmt/archive/#{version}.tar.gz"
  sha256 "32662d3fb9107dec231a2b1253afc95f8088c5974fd7ee1a3d2f8aac58099609"
  depends_on "cmake" => :build
  depends_on "qt5" => :build

  resource "qt-creator" do
    url "https://github.com/qt-creator/qt-creator.git",
        :revision => "2ee1af2"
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
