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
    id: filterPage

    property int loading: 0;

    SilicaFlickable {

        id: filterSelections
        anchors.fill: parent
        opacity: 1.0

        PullDownMenu {
            MenuItem { text: "About HAMtower"; onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml")) }
        }

        Column {
            id: column
            width: parent.width
            height: label.implicitHeight
            opacity: 1.0

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
                    checked: appState.filtervrep;
                    text: "Voice repeaters"
                }
                TextSwitch {
                    id: typeatv
                    checked: appState.filteratv;
                    text: "ATV repeaters"
                }
                TextSwitch {
                    id: typebcn
                    checked: appState.filterbcn;
                    text: "Beacons"
                }
                TextSwitch {
                    id: typeaprs
                    checked: appState.filteraprs;
                    text: "APRS digipeaters"
                }

                SectionHeader {
                    text: "Station status"
                }

                ComboBox {
                    id: comboboxQRV
                    width: parent.width
                    label: "Show"
                    currentIndex: 0

                    menu: ContextMenu {
                        MenuItem {
                            id: statusQRV
                            text: "QRV stations"
                        }
                        MenuItem {
                            id: statusALL
                            text: "all stations"
                        }
                    }
                }

                Separator {}

                Column {
                    id: progressIndicator
                    visible: false
                    width: parent.width

                    SectionHeader {
                       text: "Loading, please wait..."
                    }

                    BusyIndicator {
                        running: true;
                        size: BusyIndicatorSize.Large
                    }


                }

                Separator {}

                Button {
                    text: "Apply"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {    progressIndicator.visible=true;
                                    appState.filtervrep = typevrep.checked;
                                    appState.filteratv = typeatv.checked;
                                    appState.filterbcn = typebcn.checked;
                                    appState.filteraprs = typeaprs.checked;
                                    appState.comboboxQRV = comboboxQRV.value;
                                    stationsDataModel.updateModel();
                                    progressIndicator.visible=false;
                                    pageStack.pop()
                    }
                }
            }

        }
}
}
