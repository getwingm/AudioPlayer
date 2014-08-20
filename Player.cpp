#include "player.h"

Player::Player(QObject *parent) :
    QObject(parent)
{
    player = new QMediaPlayer();
    playlist = new QMediaPlaylist();
    dialog = new QFileDialog();
    dialog->setNameFilter(tr("Music files (*.mp3 *.wav *.ogg *.flac)"));

    connect(dialog, SIGNAL(filesSelected(QStringList)), this, SLOT(addMedia(QStringList)));
    connect(player, SIGNAL(metaDataChanged()), this, SLOT(metaDataChanged()));
    connect(player, SIGNAL(durationChanged(qint64)), this, SIGNAL(durationChanged(qint64)));
    connect(player, SIGNAL(positionChanged(qint64)), this, SIGNAL(positionChanged(qint64)));
    connect(player, SIGNAL(stateChanged(QMediaPlayer::State)), this, SLOT(playerStateChanged()));

    player->setVolume(50);
    player->setPlaylist(playlist);
}

void Player::addMedia(QStringList list){
    if(!playlist->isEmpty() &&
            QMessageBox::question(0, tr("Audio Player"), tr("Clear current playlist?"), QMessageBox::Yes, QMessageBox::No)
            == QMessageBox::Yes){
        playlist->clear();
        musicList.clear();
    }

    for(int i = 0; i < list.size(); i++)
        if(!QFileInfo(list.at(i)).isDir())
            musicList.append(new CAudioObject(QUrl::fromLocalFile(list.at(i))));
        else{
            QStringList filters;
            filters << "*.mp3" << "*.wav" << "*.ogg" << "*.flac";
            QDirIterator iter(list.at(i), filters, QDir::NoDotAndDotDot | QDir::Files | QDir::Dirs,
                              QDirIterator::FollowSymlinks | QDirIterator::Subdirectories);
            while (iter.hasNext()) {
                QString currentFile = iter.next();
                if(!QFileInfo(currentFile).isDir())
                    musicList.append(new CAudioObject(QUrl::fromLocalFile(currentFile)));
            }
        }
    for(int i = 0; i < musicList.size(); i++){
        playlist->addMedia(QMediaContent(musicList.at(i)->url()));
    }
}

void Player::metaDataChanged(){
    if(m_title != player->metaData(QMediaMetaData::Title).toString()){
        m_title = player->metaData(QMediaMetaData::Title).toString();
        emit titleChanged();
    }
    if(m_albumTitle != player->metaData(QMediaMetaData::AlbumTitle).toString()){
        m_albumTitle = player->metaData(QMediaMetaData::AlbumTitle).toString();
        emit albumTitleChanged();
    }
    if(m_albumArtist != player->metaData(QMediaMetaData::AlbumArtist).toString()){
        m_albumArtist = player->metaData(QMediaMetaData::AlbumArtist).toString();
        emit albumArtistChanged();
    }
}

void Player::seek(qreal pos){
    player->setPosition(qRound64(pos * player->duration()));
}

void Player::playPause(){
    if(player->state() == QMediaPlayer::PlayingState)
        player->pause();
    else
        player->play();

}

void Player::playerStateChanged(){
    emit stateChanged(player->state() == QMediaPlayer::PlayingState? true : false);
}

void Player::addFiles(){
    dialog->setFileMode(QFileDialog::ExistingFiles);
    dialog->show();
}

void Player::addDir(){
    dialog->setFileMode(QFileDialog::Directory);
    dialog->show();
}

void Player::previous(){
    if(player->position() < 5000)
        playlist->previous();
    else
        player->setPosition(0);
}

void Player::next(){
    playlist->next();
}

void Player::changeRandom(bool state){
    if(state){
        memory = playlist->playbackMode();
        playlist->setPlaybackMode(QMediaPlaylist::Random);
    }else
        playlist->setPlaybackMode(memory);
}

void Player::changeRepeat(QString state){
    if(state =="seq"){
        memory = QMediaPlaylist::Sequential;
        if(playlist->playbackMode() != QMediaPlaylist::Random)
            playlist->setPlaybackMode(memory);
    }else if(state =="loop"){
        memory = QMediaPlaylist::Loop;
        if(playlist->playbackMode() != QMediaPlaylist::Random)
            playlist->setPlaybackMode(memory);
    }else if(state =="loopone"){
        memory = QMediaPlaylist::CurrentItemInLoop;
        if(playlist->playbackMode() != QMediaPlaylist::Random)
            playlist->setPlaybackMode(memory);
    }else{
        memory = QMediaPlaylist::CurrentItemOnce;
        if(playlist->playbackMode() != QMediaPlaylist::Random)
            playlist->setPlaybackMode(memory);
    }
}
