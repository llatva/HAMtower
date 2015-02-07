//
//  Copyright (c) 2014-2015 Lasse Latva OH3HZB.
//
// HAMtower is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// HAMtower is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

    id: aboutPage

    SilicaFlickable {

    anchors.fill: parent

//    Row {
//        id: nameLogo
//        anchors.top: parent.top
//        width: parent.width
//        height: 120

    Column {
        id: aboutInfoContainer
        width: aboutPage.width
        spacing: Theme.paddingLarge

        PageHeader {
            title: 'About HAMtower'
        }


        Image {
            source: "../pics/hamtower-logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
            x: Theme.paddingLarge
        }
        Label {
            id: versionLabel
            color: Theme.highlightColor
            font.family: Theme.primaryColor
            x: Theme.paddingLarge
            text: "HAMtower version 0.9"
        }

        Label {
            text: 'HAMtower is a mobile client for the Finnish amateur radio (HAM) repeater/beacon database automatic.sral.fi.'
            width: parent.width - Theme.paddingLarge - Theme.paddingLarge
            x: Theme.paddingLarge
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            text: 'Copyright © 2014 Lasse Latva OH3HZB'
            width: parent.width - Theme.paddingLarge - Theme.paddingLarge
            x: Theme.paddingLarge
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            text: 'HAMtower is free software licenced under the GNU Public License version 2 (GPLv2) and it is provided \"AS IS\" without warranty of any kind.\n\nInternet connection is required to fetch the data, operator charges may apply.'
            width: parent.width - Theme.paddingLarge - Theme.paddingLarge
            x: Theme.paddingLarge
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeExtraSmall
        }

        Button {
                   anchors.horizontalCenter: parent.horizontalCenter
                   text: qsTr("View license")
                   onClicked: {
                       pageStack.push(Qt.resolvedUrl("LicensePage.qml"));
                   }
               }


    }

    }

}
