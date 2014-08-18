import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Dialogs 1.2
import QtMultimedia 5.0

Window {
    id: window
    visible: true
    width: 480
    height: 640

    Audio{
        id:player
        source: "file:///mnt/sdcard/Sounds/Nirvana - Smells Like Teen Spirit.mp3"
        onPositionChanged:{
            currentScreen.changePosition(player.position)
            currentScreen.setDuration(player.duration)
        }
        onSourceChanged:
            currentScreen.albumTitle = metaData.albumTitle.toString()
    }

    CurrentScreen{
        id:currentScreen
        onPlayPause: {
                player.play()
        }
        onSeek: {player.seek(pos*player.duration)}
    }
}
