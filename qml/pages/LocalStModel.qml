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

Item {
    property string source: ""
    property string query: ""
    property bool qrvlimit: false;

    property ListModel model : ListModel {
        id: localStModel
    }

    property alias count: localStModel.count

    onQueryChanged: {
        console.log("Updating model as query changed...")
        updateModel();
    }

    function filterBySearchString(i, textstr) {
       if (textstr === "" || jsonDataModel.model.get(i).name.toUpperCase().indexOf(textstr.toUpperCase()) >= 0 || jsonDataModel.model.get(i).callsign.toUpperCase().indexOf(textstr.toUpperCase()) >= 0) {
           localStModel.append(jsonDataModel.model.get(i));
       }
    }

    function updateModel() {

        appState.busy=true;
        console.log("stationListModel update...")

        if(jsonDataModel.count === 0) {
            console.log("JSON model seems empty, let's fetch some JSON data to populate it..")
            jsonDataModel.updateJSONModel();
            console.log("JSON model count: " + jsonDataModel.count)
        }

        qrvlimit = true;
        if(appState.comboboxQRV === "all stations") {
            qrvlimit = false;
        }

        // if every selection is false, then toggle all to true:
        if(appState.filtervrep === false && appState.filteratv === false && appState.filterbcn === false && appState.filteraprs === false) {
            appState.filtervrep = true;
            appState.filterbcn = true;
            appState.filteratv = true;
            appState.filteraprs = true;
        }

        localStModel.clear();
        console.log("stationListModel cleared.")

        for(var i = 0; i < jsonDataModel.count; ++i) {
            // Voice repeaters:
            if((appState.filtervrep === true) && (jsonDataModel.model.get(i).type === "1") && (qrvlimit === false || jsonDataModel.model.get(i).status === "QRV" || jsonDataModel.model.get(i).status === "EVENT")) {
                filterBySearchString(i, appState.searchString);
            }
            // Beacons:
            if((appState.filterbcn === true) && (jsonDataModel.model.get(i).type === "2") && (qrvlimit === false || jsonDataModel.model.get(i).status === "QRV" || jsonDataModel.model.get(i).status === "EVENT")) {
                filterBySearchString(i, appState.searchString);
            }
            // APRS digipeaters:
            if((appState.filteraprs === true) && (jsonDataModel.model.get(i).type === "3") && (qrvlimit === false || jsonDataModel.model.get(i).status === "QRV" || jsonDataModel.model.get(i).status === "EVENT")) {
                filterBySearchString(i, appState.searchString);
            }
            // ATV repeaters:
            if((appState.filteratv === true) && (jsonDataModel.model.get(i).type === "4") && (qrvlimit === false || jsonDataModel.model.get(i).status === "QRV" || jsonDataModel.model.get(i).status === "EVENT")) {
                filterBySearchString(i, appState.searchString);
            }
        }
        console.log("stationListModel successfully populated with " + localStModel.count + " records from JSONModel.");
        appState.busy=false;
    }
}
