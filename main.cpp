#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtMultimedia>
#include <QtQuick>
#include "player.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<Player>("Audio", 1, 0, "Player");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
