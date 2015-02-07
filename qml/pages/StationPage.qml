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
    id: stationPage

    // the following is not pretty at all, but it seems to work:

    property int stationIndex
    property string stid: Helper.getStField(stationsDataModel.model.get(stationIndex).id)
    property string ststatus: Helper.getStField(stationsDataModel.model.get(stationIndex).status)
    property string stname: Helper.getStField(stationsDataModel.model.get(stationIndex).name)
    property string sttype: Helper.getStField(stationsDataModel.model.get(stationIndex).type)
    property string stmode: Helper.getStField(stationsDataModel.model.get(stationIndex).mode)
    property string stband_shortname: Helper.getStField(stationsDataModel.model.get(stationIndex).band_shortname)
    property string stcallsign: Helper.getStField(stationsDataModel.model.get(stationIndex).callsign)
    property string station_url: Helper.getStField(stationsDataModel.model.get(stationIndex).station_url)
    property string stdesc: Helper.getStField(stationsDataModel.model.get(stationIndex).stdesc)
    property string stcwid: Helper.getStField(stationsDataModel.model.get(stationIndex).cwid)
    property string stqth_city: Helper.getStField(stationsDataModel.model.get(stationIndex).qth_city)
    property string stlocator: Helper.getStField(stationsDataModel.model.get(stationIndex).locator)
    property string stsite_desc: Helper.getStField(stationsDataModel.model.get(stationIndex).site_desc)
    property string stwgs84lat: Helper.getStField(stationsDataModel.model.get(stationIndex).wgs84lat)
    property string stwgs84lon: Helper.getStField(stationsDataModel.model.get(stationIndex).wgs84lon)
    property string stalt_asl: Helper.getStField(stationsDataModel.model.get(stationIndex).alt_asl)
    property string stalt_agl: Helper.getStField(stationsDataModel.model.get(stationIndex).alt_agl)
    property string sttx_freq: Helper.getStField(stationsDataModel.model.get(stationIndex).tx_freq)
    property string sttx_power: Helper.getStField(stationsDataModel.model.get(stationIndex).tx_power)
    property string sttx_ant: Helper.getStField(stationsDataModel.model.get(stationIndex).tx_ant)
    property string sttx_antpol: Helper.getStField(stationsDataModel.model.get(stationIndex).tx_antpol)
    property string stqtf: Helper.getStField(stationsDataModel.model.get(stationIndex).qtf)
    property string strx_ant: Helper.getStField(stationsDataModel.model.get(stationIndex).rx_ant)
    property string strx_antpol: Helper.getStField(stationsDataModel.model.get(stationIndex).rx_antpol)
    property string strep_access: Helper.getStField(stationsDataModel.model.get(stationIndex).rep_access)
    property string strep_shift: Helper.getStField(stationsDataModel.model.get(stationIndex).rep_shift)
    property string stband_name: Helper.getStField(stationsDataModel.model.get(stationIndex).band_name)
    property string stresponsible_club: Helper.getStField(stationsDataModel.model.get(stationIndex).responsible_club)
    property string stresponsible_club_url: Helper.getStField(stationsDataModel.model.get(stationIndex).responsible_club_url)
    property string stremarks: Helper.getStField(stationsDataModel.model.get(stationIndex).remarks)
    property string stlast_modified: Helper.getStField(stationsDataModel.model.get(stationIndex).last_modified)

    onStatusChanged: {
        if(status === PageStatus.Active) {
           appState.currentPage = "stationPage";
           appState.init = false;
           // console.log("Current page: " + appState.currentPage)
       }
    }

    SilicaFlickable {

        id: stationView
        anchors.fill: parent
        contentWidth: parent.width-Theme.paddingLarge
        contentHeight: contents.height

        Column {
            id: contents
            anchors.leftMargin: 10
            width: parent.width
//            anchors.fill: parent

            PageHeader {
                id: header
                title: "automatic.sral.fi"
            }

            // icon and main title:
            Row {
                Image {
                   id: sticon
                   source: "../pics/" + Helper.getListIconForStationType(sttype)
                   width: 70; height: 50
                   fillMode: Image.PreserveAspectFit
                   smooth: true
                }
                Label {
                    color: Theme.highlightColor
                    font.bold: true
                    font.pixelSize: Theme.fontSizeLarge
                    text: stname
                }
            }

            Label {
                anchors.leftMargin: 5
                color: Theme.highlightColor
                font.bold: true
                font.pixelSize: Theme.fontSizeMedium
                text: stcallsign + " (" + stband_name + ")"
            }

            Label {
                id: typeStatusLine
                font.pixelSize: Theme.fontSizeSmall
                text: Helper.getTypeAsText(sttype) + ", " + ststatus
            }

            Item {
                height: Theme.paddingLarge
            }

            Column {
               anchors.topMargin: 10
               anchors.leftMargin: 10
               spacing: Theme.paddingSmall               

               // subtitle
               Label { color: Theme.highlightColor; font.italic: true; font.pixelSize: Theme.fontSizeMedium; text: "Radio parameters"}

               Label {  visible: (sttx_freq); font.pixelSize: Theme.fontSizeSmall; text: "Mode: " + stmode}
               Label {  visible: (sttx_freq); font.pixelSize: Theme.fontSizeSmall; text: "TX frequency: " + parseFloat(sttx_freq).toFixed(4) + " MHz" }
               Label {  visible: (sttx_power); font.pixelSize: Theme.fontSizeSmall; text: "TX power: " + Math.round(sttx_power) + " W"}
               Label {  visible: (sttx_ant); font.pixelSize: Theme.fontSizeSmall; text: "TX antenna: " + sttx_ant }
               Label {  visible: (sttx_antpol); font.pixelSize: Theme.fontSizeSmall; text: "TX ant. polarisation: " + sttx_antpol}
               Label {  visible: (stqtf); font.pixelSize: Theme.fontSizeSmall; text: "QTF: " + stqtf}
               Label {  visible: (strx_ant); font.pixelSize: Theme.fontSizeSmall; text: "RX antenna: " + strx_ant}
               Label {  visible: (strx_antpol); font.pixelSize: Theme.fontSizeSmall; text: "RX ant. polarisation: " + strx_antpol}
               Label {  visible: (strep_shift); font.pixelSize: Theme.fontSizeSmall; text: "Repeater shift: " + strep_shift + " MHz"}
               Label {  visible: (strep_access); font.pixelSize: Theme.fontSizeSmall; text: "Repeater access: " + strep_access}

               // subtitle
               Label { color: Theme.highlightColor; font.italic: true; font.pixelSize: Theme.fontSizeMedium; text: "Location"}

               Label {  visible: stqth_city; font.pixelSize: Theme.fontSizeSmall; text: "QTH city: " + stqth_city}
               Label {  visible: stwgs84lat; font.pixelSize: Theme.fontSizeSmall; text: "WGS84 lat: " + stwgs84lat}
               Label {  visible: stwgs84lon; font.pixelSize: Theme.fontSizeSmall; text: "WGS84 lon: " + stwgs84lon}
               Label {  visible: stlocator; font.pixelSize: Theme.fontSizeSmall; text: "Locator: " + stlocator}
               Label {  visible: stalt_asl; font.pixelSize: Theme.fontSizeSmall; text: "Altitude ASL: " + stalt_asl + " m"}
               Label {  visible: stalt_agl; font.pixelSize: Theme.fontSizeSmall; text: "Altitude AGL: " + stalt_agl + " m"}
               Label {  visible: stsite_desc; font.pixelSize: Theme.fontSizeSmall; wrapMode: Text.WrapAtWordBoundaryOrAnywhere;  text: "Site description: " + stsite_desc}

               // subtitle, shown if there is club or club_url:
               Label { visible: (stresponsible_club || stresponsible_club_url); color: Theme.highlightColor; font.italic: true; font.pixelSize: Theme.fontSizeMedium; text: "Maintenance contact"}

               Label {  visible: stresponsible_club; font.pixelSize: Theme.fontSizeSmall; text: "Responsible club:\n" + stresponsible_club}
               Label {  visible: stresponsible_club_url; font.pixelSize: Theme.fontSizeSmall; text: "Responsible club URL:\n" + stresponsible_club_url }

               // subtitle, only visible when there are remarks:
               Label { visible: stremarks; color: Theme.highlightColor; font.italic: true; font.pixelSize: Theme.fontSizeMedium; text: "Remarks"}
               Label { width: parent.width; font.pixelSize: Theme.fontSizeSmall; wrapMode: Text.WrapAtWordBoundaryOrAnywhere; text: stremarks}

               Label {  color: Theme.secondaryColor; font.pixelSize: Theme.fontSizeSmall; font.italic: true; text: "Last modified: " + stlast_modified}

            }
      }
      VerticalScrollDecorator { flickable: stationView }
    }

}



