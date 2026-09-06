import Quickshell.Services.UPower
import QtQuick
import qs

TopBarItem {
  readonly property int profile: PowerProfiles.profile

  iconSizeMultiplier: 1.125

  icon: {
    if (profile === PowerProfile.PowerSaver)
      return "mode_cool";
    if (profile === PowerProfile.Performance)
      return "mode_heat";
    return "mode_heat_cool";
  }
  color: {
    if (profile === PowerProfile.PowerSaver)
      return Config.blue;
    if (profile === PowerProfile.Performance)
      return Config.orange;
    return Config.purple;
  }
}
