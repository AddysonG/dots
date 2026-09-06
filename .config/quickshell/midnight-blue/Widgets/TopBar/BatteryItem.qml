import Quickshell.Services.UPower
import QtQuick
import qs

TopBarItem {
  id: batteryItem

  iconSizeMultiplier: 1.25

  readonly property var battery: UPower.displayDevice
  readonly property real level: battery ? battery.percentage : 0
  readonly property bool charging: battery && !UPower.onBattery

  icon: {
    if (charging)
      return "battery_android_frame_bolt";
    if (level <= 0)
      return "battery_android_0";
    if (level < 1 / 6)
      return "battery_android_frame_1";
    if (level < 2 / 6)
      return "battery_android_frame_2";
    if (level < 3 / 6)
      return "battery_android_frame_3";
    if (level < 4 / 6)
      return "battery_android_frame_4";
    if (level < 5 / 6)
      return "battery_android_frame_5";
    return "battery_android_frame_full";
  }
  text: Math.round(level * 100)
  color: {
    if (level > 0.25)
      return Config.green;
    if (level > 0.15)
      return Config.orange;
    return Config.red;
  }
}
