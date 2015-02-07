import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            height: header.height + label.implicitHeight

            PageHeader {
                id: header
                title: qsTr("automatic.sral.fi - Filters")
            }

            Label {
                id: label

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingMedium
                anchors.rightMargin: Theme.paddingMedium
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pixelSize: Theme.fontSizeExtraSmall
            }
            SectionHeader {
                text: "Station type"
            }

            // these selections should come from API (station_types):
            Column {
                width: parent.width
                TextSwitch {
                    id: typevrep
                    checked: true
                    text: "Voice repeaters"
                }
                TextSwitch {
                    id: typeatv
                    checked: true
                    text: "ATV repeaters"
                }
                TextSwitch {
                    id: typebcn
                    checked: true
                    text: "Beacons"
                }
                TextSwitch {
                    id: typeaprs
                    checked: true
                    text: "APRS digipeaters"
                }
           }

            SectionHeader {
                text: "Station status"
            }

            Column {
                width: parent.width

                ComboBox {
                    width: parent.width
                    label: "Show"
                    currentIndex: 1

                    menu: ContextMenu {
                        MenuItem { text: "all stations" }
                        MenuItem { text: "QRV stations" }
                    }
                }

            }

            Column {
                width: parent.width

                Separator {}

                Button {
                    text: "Apply"
                    anchors.horizontalCenter: parent.horizontalCenter
                    // TBD: first update the model
                    onClicked: pageStack.pop()
                }
            }

        ScrollDecorator { }
      }
    }
}
