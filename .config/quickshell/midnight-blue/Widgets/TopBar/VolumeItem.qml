import Quickshell.Services.Pipewire
import QtQuick
import qs

TopBarItem {
  id: volume

  iconSizeMultiplier: 1.125

  readonly property var sink: Pipewire.defaultAudioSink
  readonly property var audio: sink ? sink.audio : null

  icon: {
    if (!audio || audio.muted)
      return "volume_off"
    if (audio.volume === 0)
      return "volume_mute"
    if (audio.volume < 0.49)
      return "volume_down"
    return "volume_up"
  }
  text: audio ? Math.round(audio.volume * 10) : "0"
  color: Config.purple

  PwObjectTracker {
    objects: [volume.sink]
  }
}
