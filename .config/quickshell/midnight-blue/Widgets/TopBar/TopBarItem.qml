import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import qs

RowLayout {
  id: root

  property string icon: ""
  property string text: ""
  property color color: Config.text
  property double iconSizeMultiplier: 1.0

  implicitHeight: Config.barHeight

  Item {
    implicitWidth: icon.implicitWidth
    implicitHeight: icon.implicitHeight

    MultiEffect {
      source: icon
      anchors.fill: icon
      shadowEnabled: true
      shadowColor: Config.bg
      shadowBlur: 0.6
    }

    Text {
      id: icon
      font: Config.iconFont
      color: root.color
      text: root.icon

      Binding {
        target: icon
        property: "font.pixelSize"
        value: Config.iconFont.pixelSize * iconSizeMultiplier
      }
    }
  }

  Item {
    visible: root.text.length > 0
    implicitWidth: text.implicitWidth
    implicitHeight: text.implicitHeight

    MultiEffect {
      source: text
      anchors.fill: text
      shadowEnabled: true
      shadowColor: Config.bg
      shadowBlur: 0.6
    }

    Text {
      id: text
      font: Config.mainFont
      color: root.color
      text: root.text
    }
  }
}
