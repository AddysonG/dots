import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Effects
import qs

TopBarItem {
  id: playerItem

  readonly property var player: {
    const players = Mpris.players.values;
    for (const candidate of players) {
      const identifiers = [candidate.identity, candidate.desktopEntry, candidate.dbusName];
      if (identifiers.some(identifier => String(identifier || "").toLowerCase().includes("spotify")))
        return candidate;
    }

    return null;
  }
  readonly property string title: player ? player.trackTitle : ""
  readonly property string artist: player ? player.trackArtist : ""
  readonly property real maximumTextWidth: 400

  icon: "headphones"
  text: ""
  color: Config.text1
  visible: player !== null && title.length > 0

  Item {
    implicitWidth: titleLabel.implicitWidth
    implicitHeight: titleLabel.implicitHeight

    MultiEffect {
      source: titleLabel
      anchors.fill: titleLabel
      shadowEnabled: true
      shadowColor: Config.bg
      shadowBlur: 0.6
    }

    Text {
      id: titleLabel
      font: Config.mainFont
      color: Config.text1
      text: titleMetrics.elidedText
    }
  }

  Item {
    visible: playerItem.artist.length > 0
    implicitWidth: separatorLabel.implicitWidth
    implicitHeight: separatorLabel.implicitHeight

    MultiEffect {
      source: separatorLabel
      anchors.fill: separatorLabel
      shadowEnabled: true
      shadowColor: Config.bg
      shadowBlur: 0.6
    }

    Text {
      id: separatorLabel
      font: Config.mainFont
      color: Config.text3
      text: "・"
    }
  }

  Item {
    visible: playerItem.artist.length > 0
    implicitWidth: artistLabel.implicitWidth
    implicitHeight: artistLabel.implicitHeight

    MultiEffect {
      source: artistLabel
      anchors.fill: artistLabel
      shadowEnabled: true
      shadowColor: Config.bg
      shadowBlur: 0.6
    }

    Text {
      id: artistLabel
      font: Config.mainFont
      color: Config.text3
      text: artistMetrics.elidedText
    }
  }

  TextMetrics {
    id: titleMetrics
    font: Config.mainFont
    text: playerItem.title
    elide: Text.ElideRight
    elideWidth: playerItem.maximumTextWidth
  }

  TextMetrics {
    id: artistMetrics
    font: Config.mainFont
    text: playerItem.artist
    elide: Text.ElideRight
    elideWidth: playerItem.maximumTextWidth
  }
}
