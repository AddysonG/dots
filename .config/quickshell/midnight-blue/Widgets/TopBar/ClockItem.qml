import QtQuick
import qs

TopBarItem {
  id: clock
  icon: "schedule"
  text: Qt.formatTime(new Date(), "HH:mm")
  color: Config.blue

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: clock.text = Qt.formatDateTime(new Date(), "M/d HH:mm")
  }
}
