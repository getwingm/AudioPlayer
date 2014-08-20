#include "caudioobject.h"
#include <QMediaPlayer>

CAudioObject::CAudioObject(QUrl Url, QObject *parent) :
    QObject(parent)
{
    m_url = Url;
    QMediaPlayer player;
    player.setMedia(QMediaContent(m_url));
    m_avaiableMetaData = player.availableMetaData();
    emit avaiableMetaDataChanged();
    for (int i = 0; i < m_avaiableMetaData.size(); i++)
        m_metaData[m_avaiableMetaData.at(i)] = player.metaData(m_avaiableMetaData.at(i));
    emit metaDataChanged();
}

bool CAudioObject::operator ==(CAudioObject & obj) const{
    return m_url == obj.url();
}
