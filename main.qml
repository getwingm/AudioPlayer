import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Dialogs 1.2
import Audio 1.0

Window {
    id: window
    visible: true
    width: 480
    height: 640

    Player{
        id:player
        onPositionChanged: currentScreen.changePosition(pos)
        onDurationChanged: currentScreen.setDuration(dur)
        onTitleChanged: currentScreen.title = player.title
        onAlbumTitleChanged: currentScreen.albumTitle = player.albumTitle
        onAlbumArtistChanged: currentScreen.artist = player.albumArtist
        onStateChanged: currentScreen.setPlaying(isPlaying)
    }

    CurrentScreen{
        id:currentScreen
        onPlayPause: {
                player.playPause()
        }
        onSeek: player.seek(pos)
        onNext: player.next()
        onPrevious: player.previous()
        onOpenSettings: {
            settings.closeAreaWidth = window.width - settings.width
            settingsOpen.start()
        }
    }

    Settings{
        id: settings
        width: window.width*5/12
        x: -width
        onOpenFilesClicked: player.addFiles()
        onOpenDirectoryClicked: player.addDir()
        onRandomChanged: player.changeRandom(settings.random)
        onRepeatChanged: player.changeRepeat(settings.repeat)
        onCloseClicked: {
            settings.closeAreaWidth = 0
            settingsClose.start()
        }
    }

    NumberAnimation {
        id:settingsOpen
        target: settings
        property: "x"
        duration: 200
        to:0
    }
    NumberAnimation {
        id:settingsClose
        target: settings
        property: "x"
        duration: 200
        to: -settings.width
    }
}
