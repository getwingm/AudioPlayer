#include "player.h"

Player::Player(QObject *parent) :
    QObject(parent)
{
    player = new QMediaPlayer();
    dialog = new QFileDialog();
    connect(dialog, SIGNAL(fileSelected(QString)), this, SLOT(startPlaying(QString)));
    connect(player, SIGNAL(metaDataChanged()), this, SLOT(metaDataChanged()));
    connect(player, SIGNAL(durationChanged(qint64)), this, SIGNAL(durationChanged(qint64)));
    connect(player, SIGNAL(positionChanged(qint64)), this, SIGNAL(positionChanged(qint64)));
    connect(player, SIGNAL(stateChanged(QMediaPlayer::State)), this, SLOT(playerStateChanged()));
    QTimer::singleShot(10, this, SLOT(setFile()));
}

void Player::startPlaying(QString url){
    player->setMedia(QUrl::fromLocalFile(url));
    player->setVolume(50);
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

void Player::setFile(){
    player->stop();
    dialog->show();
}
