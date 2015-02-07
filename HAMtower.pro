# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = HAMtower

CONFIG += sailfishapp

SOURCES += src/HAMtower.cpp

OTHER_FILES += qml/HAMtower.qml \
    rpm/HAMtower.spec \
    rpm/HAMtower.yaml \
    HAMtower.desktop \
    qml/pages/MainPage.qml \
    qml/jsonpath.js \
    qml/CoverPage.qml \
    qml/pages/JSONListModel.qml \
    qml/pages/jsonpath.js \
    qml/pages/LicensePage.qml \
    qml/pages/StationPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/helper.js \
    qml/pages/MapView.qml \
    qml/pages/FilterPage.qml \
    qml/pages/LocalStModel.qml

