#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "mainwindow.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    mainWindow mainObject;
    app.setOrganizationDomain("textEditor");
    app.setOrganizationDomain("Ankit Gupta");
    QQmlContext * rootContext = engine.rootContext();
    rootContext->setContextProperty("backend", &mainObject);


    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
