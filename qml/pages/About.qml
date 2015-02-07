import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

    id: aboutPage

    SilicaFlickable {

    anchors.fill: parent

    Column {
        id: aboutInfoContainer
        width: aboutPage.width
        spacing: Theme.paddingLarge

        PageHeader {
            title: 'About HAMtower'
        }

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../pics/hamtower-logo.png"
            x: Theme.paddingLarge
        }

        Label {
            id: versionLabel
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.highlightColor
            font.family: Theme.primaryColor
            x: Theme.paddingLarge
            text: "HAMtower version 0.1"
        }

        Label {
            text: 'HAMtower is a mobile client for the Finnish amateur radio (HAM) repeater/beacon database'
            width: parent.width - Theme.paddingLarge - Theme.paddingLarge
            x: Theme.paddingLarge
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            text: 'Copyright (c) 2014- Lasse Latva OH3HZB'
            width: parent.width - Theme.paddingLarge - Theme.paddingLarge
            x: Theme.paddingLarge
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            text: 'HAMtower is free sofware licenced under the GNU Public License version 2 (GPLv2).\n\nThis software is provided \"AS IS\" without warranty of any kind and it transfers data from the Internet, operator charges may apply.'
            width: parent.width - Theme.paddingLarge - Theme.paddingLarge
            x: Theme.paddingLarge
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeExtraSmall
        }

        Button {
                   anchors.horizontalCenter: parent.horizontalCenter
                   text: qsTr("License")
                   onClicked: {
                       pageStack.push(Qt.resolvedUrl("LicensePage.qml"));
                   }
               }


    }

    }

}
