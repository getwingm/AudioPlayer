#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>
#include <QMediaMetaData>
#include <QtMultimedia>
#include <QFileDialog>

class Player : public QObject
{
    Q_OBJECT
public:
    explicit Player(QObject *parent = 0);

    Q_PROPERTY(QString title READ title NOTIFY titleChanged)
    Q_PROPERTY(QString albumTitle READ albumTitle NOTIFY albumTitleChanged)
    Q_PROPERTY(QString albumArtist READ albumArtist NOTIFY albumArtistChanged)


signals:
    void titleChanged();
    void albumTitleChanged();
    void albumArtistChanged();
    void positionChanged(qint64 pos);
    void durationChanged(qint64 dur);
    void stateChanged(bool isPlaying);

public:
    QString albumTitle() const {return m_albumTitle;}
    QString title() const {return m_title;}
    QString albumArtist() const {return m_albumArtist;}

public slots:
    Q_INVOKABLE void seek(qreal pos);
    Q_INVOKABLE void playPause();
    Q_INVOKABLE void setFile();

private slots:
    void startPlaying(QString url);
    void metaDataChanged();
    void playerStateChanged();

private:
    QMediaPlayer *player;
    QFileDialog *dialog;
    QString m_title;
    QString m_albumTitle;
    QString m_albumArtist;
};

#endif // PLAYER_H
