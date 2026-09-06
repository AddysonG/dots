import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs

RowLayout {
  id: root

  spacing: Config.workspaceSpacing
  implicitHeight: Config.barHeight

  readonly property var orderedItems: {
    const fcitx = [];
    const others = [];
    const items = SystemTray.items.values;

    for (let i = 0; i < items.length; ++i) {
      const item = items[i];

      if (item.id === "Fcitx")
        fcitx.push(item);
      else
        others.push(item);
    }

    others.sort((a, b) => {
      const titleA = (a.title || a.id).toLocaleLowerCase();
      const titleB = (b.title || b.id).toLocaleLowerCase();
      const titleOrder = titleA.localeCompare(titleB);

      return titleOrder !== 0 ? titleOrder : a.id.localeCompare(b.id);
    });

    return others.concat(fcitx);
  }

  Repeater {
    model: root.orderedItems

    delegate: Item {
      id: trayIcon

      required property var modelData

      visible: modelData.status !== Status.Passive
      implicitWidth: modelData.id === "Fcitx" ? Config.fcitxTrayIconSize : Config.trayIconSize
      implicitHeight: Config.barHeight

      function showMenu() {
        if (!modelData.hasMenu)
          return;

        const position = trayIcon.QsWindow.mapFromItem(trayIcon, 0, trayIcon.height);
        modelData.display(trayIcon.QsWindow.window, position.x, position.y);
      }

      IconImage {
        anchors.centerIn: parent
        implicitSize: trayIcon.modelData.id === "Fcitx" ? Config.fcitxTrayIconSize : Config.trayIconSize
        source: trayIcon.modelData.icon
      }

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

        onClicked: mouse => {
          if (mouse.button === Qt.RightButton) {
            trayIcon.showMenu();
          } else if (mouse.button === Qt.MiddleButton) {
            trayIcon.modelData.secondaryActivate();
          } else if (trayIcon.modelData.onlyMenu) {
            trayIcon.showMenu();
          } else {
            trayIcon.modelData.activate();
          }
        }

        onWheel: wheel => {
          const horizontal = wheel.angleDelta.x !== 0;
          const delta = horizontal ? wheel.angleDelta.x : wheel.angleDelta.y;
          trayIcon.modelData.scroll(delta, horizontal);
        }
      }
    }
  }
}
