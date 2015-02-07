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
import QtLocation 5.0

import "helper.js" as Helper

Page {
    id: mapView

    property int sttype;
    property real stwgs84lat;
    property real stwgs84lon;

    Map {
         id: map
         width: parent.width
         height: parent.height
         anchors.bottom: parent.bottom
         clip: true
         plugin: Plugin {
             name: "osm"
         }

         center: currentLocation.coordinate
//         center: QtPositioning.coordinate(65.65, 26.8)

         Component.onCompleted: {
             map.zoomLevel = 6;
//             map.zoomLevelPrev = map.zoomLevel;
             map.gps.start();
         }

         MapQuickItem {
             anchors.right: parent.right
             anchors.bottom: parent.bottom
             sourceItem: Rectangle {
                 color: "white"
                 opacity: 0.6
                 width: contributionLabel.width
                 height: contributionLabel.height
                 Label {
                     id: contributionLabel
                     font.pixelSize: Theme.fontSizeTiny
                     color: "black"
                     text: "(C) OpenStreetMap contributors"
                 }
             }
         }

        MapItemView {
           model: stationsDataModel.model
            delegate:
                 // marker delegate:
                 MapQuickItem {
                     anchorPoint.x: image.width/2
                     anchorPoint.y: image.height/2
//                     coordinate {
//                          latitude: model.wgs84lat //.toDouble();
//                          longitude: model.wgs84lon //.toDouble();
//                     }
                     sourceItem: Image {
                         id: image
                         smooth: true
                         width: 50; height: 35
                         fillMode: Image.PreserveAspectFit
                         source: "../pics/" + Helper.getListIconForStationType(model.type)
                         }
                 }
        }
    }
}
