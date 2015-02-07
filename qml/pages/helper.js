//
//  Copyright (c) 2014 Lasse Latva OH3HZB.
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


// if null, return empty string "":
function getStField(inputData) {
    if(!(appState.init)) {
        if (!inputData || inputData.length == 0) {
            return "";
           }
        else {
            return inputData;
        }
    }
    else {
        return "";
    }
}

function getListIconForStationType(type) {

    if(type == 1) {
        return "repeater_small.svg"
    }
    else if(type == 2) {
        return "beacon_small.svg"
    }
    else if(type == 3) {
        return "digipeater_small.svg"
    }
    else if(type == 4) {
        return "atv_simple_orange.svg"
    }
    else {
        return "group_repeater.png"
    }

}

function getTypeAsText(type) {
    if(type == 1) {
        return "Voice repeater"
    }
    else if(type == 2) {
        return "Beacon"
    }
    else if(type == 3) {
        return "Digipeater"
    }
    else if(type == 4) {
        return "ATV repeater"
    }
    else {
        return "Unknown"
    }

}


function getStVal(stationIndex,fieldname) {
    return stationsDataModel.model.get(stationIndex).fieldname
}


