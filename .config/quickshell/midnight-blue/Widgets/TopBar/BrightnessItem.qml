import Quickshell.Io
import QtQuick
import qs

TopBarItem {
  id: brightnessItem

  readonly property real brightness: Number(currentBrightness.text()) / Number(maxBrightness.text())

  icon: {
    if (brightness === 0)
      return "brightness_empty"
    if (brightness < 0.49)
      return "brightness_medium"
    return "brightness_7"
  }
  text: Math.round(brightness * 10)
  color: Config.yellow

  FileView {
    id: currentBrightness
    path: "/sys/class/backlight/intel_backlight/actual_brightness"
    watchChanges: true
    onFileChanged: reload()
  }

  FileView {
    id: maxBrightness
    path: "/sys/class/backlight/intel_backlight/max_brightness"
  }
}
