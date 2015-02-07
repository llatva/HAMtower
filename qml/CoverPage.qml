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

import "../qml/pages/helper.js" as Helper

CoverBackground {

    CoverPlaceholder {
         // text: ""
         visible: ((stationsDataModel.count === 0) || appState.init)
         icon.source: "pics/coverbg.png"
    }

    // this is shown on other pages than station page:
    Column {
        visible: appState.init

        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: Theme.paddingLarge
        anchors.rightMargin: Theme.paddingLarge
        anchors.bottomMargin: Theme.paddingLarge * 3.3

        Label {
            anchors.leftMargin: Theme.paddingLarge
            anchors.bottomMargin: Theme.paddingLarge * 3.3
            color: Theme.secondaryColor
            font.bold: true;
            font.pixelSize: Theme.fontSizeMedium
            text: "HAMtower "
        }
    }

    // this is shown on station page:
    Column {

        enabled: (!appState.init  && (stationsDataModel.count > 0))
        visible: !(appState.init)

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.leftMargin: Theme.paddingLarge
        anchors.rightMargin: Theme.paddingLarge
        anchors.bottomMargin: Theme.paddingLarge

        Label {
            anchors.leftMargin: Theme.paddingLarge
            anchors.bottomMargin: Theme.paddingLarge * 3.3
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeTiny
            text: "HAMtower [station " + (appState.currentStation+1) + "/" + stationsDataModel.model.count + "]\n"
        }
        // title text for station in Cover:
        Row {
            Image {
               id: sticon
               enabled: parent.enabled
               source: "pics/" + Helper.getListIconForStationType(stationsDataModel.model.get(appState.currentStation).type)
               width: 70; height: 50
               fillMode: Image.PreserveAspectFit
               smooth: true
            }
            Column {
                Label {
                    enabled: parent.enabled
                    color: Theme.highlightColor
                    font.bold: true
                    font.pixelSize: Theme.fontSizeSmall
                    text: stationsDataModel.model.get(appState.currentStation).callsign ? Helper.getStField(stationsDataModel.model.get(appState.currentStation).callsign) : ""
                }
                // band
                Label {
                    enabled: parent.enabled
                    anchors.leftMargin: 5
                    color: Theme.highlightColor
                    font.bold: true
                    font.pixelSize: Theme.fontSizeTiny
                    text: stationsDataModel.model.get(appState.currentStation).band_name ? Helper.getStField(stationsDataModel.model.get(appState.currentStation).band_name) : ""
                }
            }
        }

        Label {
            id: typeStatusLine;
            enabled: parent.enabled
            font.pixelSize: Theme.fontSizeTiny;
            font.bold: true
            text: Helper.getTypeAsText(stationsDataModel.model.get(appState.currentStation).type) + ", " + Helper.getStField(stationsDataModel.model.get(appState.currentStation).status)
        }
        // Station's name:
        Label {
            enabled: parent.enabled
            font.pixelSize: Theme.fontSizeTiny;
            text: stationsDataModel.model.get(appState.currentStation).name ? Helper.getStField(stationsDataModel.model.get(appState.currentStation).name) : ""
        }
        // frequency
        Label {
            enabled: parent.enabled
            font.pixelSize: Theme.fontSizeTiny;
            text: "TX freq: " + Helper.getStField(stationsDataModel.model.get(appState.currentStation).tx_freq) + " MHz "
        }
        // TX power
        Label {
            enabled: parent.enabled
            font.pixelSize: Theme.fontSizeTiny;
            text: "TX power: " + Helper.getStField(Math.round(stationsDataModel.model.get(appState.currentStation).tx_power)) + " W"
        }
        // QTH city
        Label {
            enabled: parent.enabled
            visible: parent.enabled && (stationsDataModel.model.get(appState.currentStation).qth_city)
            font.pixelSize: Theme.fontSizeTiny;
            text: "QTH: " + Helper.getStField(stationsDataModel.model.get(appState.currentStation).qth_city)
        }
        // locator
        Label {
            enabled: parent.enabled
            visible: parent.enabled && (stationsDataModel.model.get(appState.currentStation).locator)
            font.pixelSize: Theme.fontSizeTiny;
            text: "Locator: " + Helper.getStField(stationsDataModel.model.get(appState.currentStation).locator)
        }
        // altitude
        Label {
            enabled: parent.enabled
            visible: parent.enabled && (stationsDataModel.model.get(appState.currentStation).alt_asl)
            font.pixelSize: Theme.fontSizeTiny;
            anchors.bottomMargin: Theme.paddingLarge * 3
            text: "Altitude: " + Helper.getStField(stationsDataModel.model.get(appState.currentStation).alt_asl) + " m ASL"
        }
    }

// bottom line showing status counts:
Column {
    anchors.bottom: parent.bottom
    anchors.bottomMargin: Theme.paddingMedium
    anchors.horizontalCenter: parent.horizontalCenter
    enabled: stationsDataModel.count > 0
    Label {
        anchors.leftMargin: 5
        anchors.topMargin: Theme.paddingLarge * 3
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeTiny
        text: stationsDataModel.count + "/" + jsonDataModel.count + " station(s)"
    }
}

// station actions:
    CoverActionList {
        id: coverActionsForStationPage
//        enabled: appState.currentPage === "stationPage"

        CoverAction {
            iconSource: "image://theme/icon-cover-previous"
            onTriggered: {
                console.log("currentStation: " + appState.currentStation)
                appState.init = false;
                appState.currentPage = "stationPage";
                if(appState.currentStation >= 1) {
                    appState.currentStation--;
                }
                else {
                    appState.currentStation = (stationsDataModel.model.count-1);
                }
                if(pageStack.depth > 1) {
                    pageStack.replace(Qt.resolvedUrl("pages/StationPage.qml"));
                    pageStack.currentPage.stationIndex = appState.currentStation;
                }
                if(pageStack.depth === 1) {
                    pageStack.push(Qt.resolvedUrl("pages/StationPage.qml"));
                    pageStack.currentPage.stationIndex = appState.currentStation;
                }
            }
        }
        CoverAction {
            iconSource: "image://theme/icon-cover-next"
            onTriggered: {
                console.log("currentStation: " + appState.currentStation)
                appState.init = false;
                appState.currentPage = "stationPage";
                if(appState.currentStation < (stationsDataModel.model.count-1)) {
                    appState.currentStation++;
                }
                else {
                    appState.currentStation = 0;
                }
                if(pageStack.depth > 1) {
                    pageStack.replace(Qt.resolvedUrl("pages/StationPage.qml"));
                    pageStack.currentPage.stationIndex = appState.currentStation;
                }
                if(pageStack.depth === 1) {
                    pageStack.push(Qt.resolvedUrl("pages/StationPage.qml"));
                    pageStack.currentPage.stationIndex = appState.currentStation;
                }
            }
        }
    }
}

