import Quickshell.Networking
import QtQuick
import qs

TopBarItem {
  id: wifiItem

  iconSizeMultiplier: 1.125

  readonly property bool ethernetConnected: {
    const devices = Networking.devices.values;
    for (const device of devices) {
      if (device.type === DeviceType.Wired && device.connected)
        return true;
    }
    return false;
  }

  readonly property var wifiNetwork: {
    const devices = Networking.devices.values;
    for (const device of devices) {
      if (device.type !== DeviceType.Wifi)
        continue;
      const networks = device.networks.values;
      for (const network of networks) {
        if (network.connected)
          return network;
      }
    }
    return null;
  }

  readonly property bool wifiConnected: wifiNetwork !== null
  readonly property real signalStrength: wifiConnected ? wifiNetwork.signalStrength : 0
  readonly property int signalLevel: wifiConnected ? Math.min(4, Math.floor(signalStrength * 5)) : 0

  icon: {
    if (ethernetConnected)
      return "cable";
    if (!wifiConnected)
      return "signal_wifi_bad";
    if (signalLevel === 0)
      return "signal_wifi_0_bar";
    if (signalLevel === 1)
      return "network_wifi_1_bar";
    if (signalLevel === 2)
      return "network_wifi_2_bar";
    if (signalLevel === 3)
      return "network_wifi_3_bar";
    return "signal_wifi_4_bar";
  }
  color: ethernetConnected || wifiConnected ? Config.cyan : Config.text2
}
