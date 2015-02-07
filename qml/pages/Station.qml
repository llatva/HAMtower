/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: subPage

    SilicaListView {
        id: stationListView
        anchors.fill: parent

        header: PageHeader {
            title: "Station info"
        }

        // pulley menu:
        PullDownMenu {
            MenuItem { text: "About HAMtower"; onClicked: pageStack.push(Qt.resolvedUrl("About.qml")) }
        }

        ListItem {
            id: titleBar
            //contentHeight: Theme.itemSizeMedium // two line delegate

            Image {
                id: stationLogo
                source: "../pics/group_repeater.png"
            }

            Label {
                id: versionLabel
                anchors.right: stationLogo
                anchors.leftMargin: 8
                color: Theme.highlightColor
                font.family: Theme.primaryColor
                x: Theme.paddingLarge
                text: "Band / Station name [CALL]"
                horizontalAlignment: versionLabel.AlignHCenter
            }
        } // ListItem

        model: ListModel {
            ListElement { field: "Status: " }
            ListElement { field: "TX frequency"; fval: "50.0" }
            ListElement { field: "TX power [W]" }
            ListElement { field: "TX antenna" }
            ListElement { field: "TX ant. pol." }
            ListElement { field: "QTF" }
            ListElement { field: "RX antenna" }
            ListElement { field: "RX ant. pol." }
            ListElement { field: "QTH (city)" }
            ListElement { field: "Locator" }
            ListElement { field: "Altitude ASL [m]"}
            ListElement { field: "Altitude AGL [m]"}
            ListElement { field: "Site description"}
            ListElement { field: "Responsible person/club"}
            ListElement { field: "Networks"}
            ListElement { field: "Remarks"}
        }

        delegate: Item {
                width: ListView.view.width
                height: Theme.itemSizeSmall

                Label { text: field + ": " + fval }
        }

        VerticalScrollDecorator {}
       }

}



