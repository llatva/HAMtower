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
//

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow {
    id: mainWindow

    // this object keeps the state of app (e.g. selected search options, selected station)..
    QtObject {
           id: appState

           property bool init: true;
           property int currentStation: 0
           property string currentPage: (pageStack.depth > 0) ? pageStack.currentPage.objectName : ""

           // search options (see filterPage.qml):
           property string searchString: ""
           property bool filtervrep: true
           property bool filterbcn: true
           property bool filteratv: true
           property bool filteraprs: true
           property string comboboxQRV: "QRV stations"
           property bool busy: true
       }

    JSONListModel {
        id: jsonDataModel
        source: "https://automatic.sral.fi/api-v1.php?query=list&apikey=asf-b682122d388fd72f9fb7c760a56866d1"
        query: "$.stations[*]"
    }

    LocalStModel {
      id: stationsDataModel
    }

    // main page:
    initialPage: mainPage
    Component {
            id: mainPage
            MainPage { }
    }
    // cover page:
    cover: coverPage

    Component {
        id: coverPage
        CoverPage { }
    }


}

