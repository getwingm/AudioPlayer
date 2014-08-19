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
        onOpenFile: player.setFile()
    }
}
