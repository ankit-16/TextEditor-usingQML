#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QObject>
#include <QTimer>
#include <QDateTime>
#include <QUrl>
#include <QFile>
#include <QTextStream>
#include <QByteArray>

class mainWindow : public QObject
{
    Q_OBJECT
    QTimer *timer;
    QString textField;

public:
    explicit mainWindow(QObject *parent = nullptr);

signals:
     void setName(QString s);
     void timeSet(QString time);
     void isVisible(bool status);
     void readText(QString fileContent);

public slots:
     void welcomeText(QString m);
     void setTime();
     void showHideRectangle(bool isChecked);
     void openFile(QString filePath);
     void getTextField(QString text);
     void writeFile(QString filepath);
};

#endif // MAINWINDOW_H
