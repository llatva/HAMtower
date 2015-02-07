import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

    id: searchPage
    property string searchString
    property bool keepSearchFieldFocus
    property string activeView: "list"

    onSearchStringChanged: listModel.update()

    Column {
        id: headerContainer

        width: searchPage.width

        PageHeader {
            title: "repeater.sral.fi"
        }

        SearchField {
            id: searchField
            width: parent.width

            Binding {
                target: searchPage
                property: "searchString"
                value: searchField.text.toLowerCase().trim()
            }
        }
    }
}
