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
import "helper.js" as Helper

Page {
    id: mainPage

    property string searchString
    property bool keepSearchFieldFocus

    function checkQRT(status) {
        if (status === "QRV") {
            return ""
        }
        else if(status === "EVENT") {
            return ""
        }
        else if(status === "QRT") {
            return " (QRT)"
        }
    }

    // display station count:
    Label {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 5
        anchors.topMargin: 5
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeTiny
        text: stationsDataModel.count + "/" + jsonDataModel.count + " station(s)"
    }

    SilicaListView {
        id: listView
        anchors.fill: parent

        // pulley menu:
        PullDownMenu {
            MenuItem { text: "About HAMtower"; onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml")) }
            // MenuItem { text: "Nearest stations"; onClicked: pageStack.push(Qt.resolvedUrl("NearbyStations.qml")) }
            // MenuItem { text: "Show on map"; onClicked: pageStack.push(Qt.resolvedUrl("MapView.qml")) }
            MenuItem { text: "Select..."; onClicked: pageStack.push(Qt.resolvedUrl("FilterPage.qml")) }
        }

        PushUpMenu {
            MenuItem { text: "Select..."; onClicked: pageStack.push(Qt.resolvedUrl("FilterPage.qml")) }
        }

        SearchField {
            id: searchField
            width: parent.width
            anchors.topMargin: 30

            onTextChanged:  {
                appState.searchString = searchField.text;
                stationsDataModel.updateModel();
            }

            Binding {
               target: mainPage
               property: "searchString"
               value: searchField.text.toLowerCase().trim()
               }
        }

        model: stationsDataModel.model

        header: PageHeader { title: "automatic.sral.fi" }

        currentIndex: -1

        delegate:

           ListItem {
                id: listItem
                contentHeight: Theme.itemSizeSmall
                 onClicked:   { appState.currentStation = index;
                                pageStack.push(Qt.resolvedUrl("StationPage.qml", { stationIndex: index } ));
                                pageStack.currentPage.stationIndex = index; }

                   Item {
                       id: upperLine

                       Image {
                          id: sticon
                          source: "../pics/" + Helper.getListIconForStationType(model.type) //  "../pics/group_repeater.png"
                          smooth: true
                          width: 50; height: 35
                          fillMode: Image.PreserveAspectFit
                          x: Theme.paddingSmall
                       }
                       Label {
                         id: upperLineLabel
                         anchors.left: sticon.right
                         anchors.leftMargin: 5
                         font.pixelSize: Theme.fontSizeMedium
                         text: model.band_shortname + " / " + model.callsign + " " + model.name + checkQRT(model.status)
                         color: (model.status === "QRT") ? Theme.secondaryColor : Theme.primaryColor
                       }
                    Label {
                        anchors.top: upperLineLabel.bottom
                        anchors.leftMargin: Theme.paddingLarge
                        text: " Loc: " + model.locator +  ", " + model.alt_asl + " m ASL, f=" + parseFloat(model.tx_freq).toFixed(4) + "MHz" + ", P=" + Math.round(model.tx_power) + "W"
                        font.pixelSize: Theme.fontSizeTiny
                        color: Theme.secondaryColor
                    }
                  } // Item
        } // listItem

        VerticalScrollDecorator {}
//                    if (keepSearchFieldFocus) {
//                       searchField.forceActiveFocus()
//                    }
//                    keepSearchFieldFocus = false
//                }
    }

    // Busy indicator with text:
    Rectangle {
        visible: appState.busy // stationsDataModel.count === 0
        enabled: visible
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.itemSizeHuge
        width: parent.width
        height: Theme.itemSizeLarge
        gradient: Gradient {
            GradientStop { position: 0; color: "transparent" }
            GradientStop { position: 0.5; color: "black" }
            GradientStop { position: 1; color: "black" }
        }

        BusyIndicator {
            running: appState.busy
            size: BusyIndicatorSize.Large
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: loadingText.top
            anchors.bottomMargin: Theme.paddingSmall
        }
        Label {
            id: loadingText
            visible: parent.visible
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge
            anchors.bottomMargin: Theme.paddingSmall
            horizontalAlignment: Text.AlignHCenter
            color: Theme.secondaryColor
            text: "Loading data, please wait..."
        }
    }

    onStatusChanged: {
        if ((mainPage.status !== undefined) && (mainPage.status === PageStatus.Active)) {
            appState.currentPage = "mainPage";
            appState.currentStation = 0;
        }
    }

}

