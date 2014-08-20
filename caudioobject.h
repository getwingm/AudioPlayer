#ifndef CAUDIOOBJECT_H
#define CAUDIOOBJECT_H


#include <QObject>
#include <QMediaMetaData>
#include <QMediaPlayer>

class CAudioObject : public QObject
{
    Q_OBJECT
public:
    explicit CAudioObject(QUrl Url, QObject *parent = 0);
    bool operator ==(CAudioObject & obj) const;

    Q_PROPERTY(QUrl url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QMap metaData READ metaData NOTIFY metaDataChanged)
    Q_PROPERTY(QStringList avaiableMetaData READ avaiableMetaData NOTIFY avaiableMetaDataChanged)

signals:
    void urlChanged();
    void metaDataChanged();
    void avaiableMetaDataChanged();

public:
    QUrl url() const {return m_url;}
    const QMap<QString, QVariant>* metaData() const
    {return &m_metaData;}
    QStringList avaiableMetaData() const
    {return m_avaiableMetaData;}

public slots:
    void setUrl(QUrl url) {m_url = url;}

private:
   QMediaPlayer *tagger;
   QUrl m_url;
   QStringList m_avaiableMetaData;
   QMap<QString, QVariant> m_metaData;

};

#endif // CAUDIOOBJECT_H
