#include "mainwindow.h"

mainWindow::mainWindow(QObject *parent) : QObject(parent)
{
    timer = new QTimer(this);
    connect(timer,SIGNAL(timeout()),this,SLOT(setTime()));
    timer->start(1000);
}


void mainWindow::welcomeText(QString s)
{
    emit setName("Welcome, " + s);
}

void mainWindow::setTime()
{
   QDateTime time = QDateTime::currentDateTime();
   QString time_text = time.toString("hh:mm:ss dd/MM/yyyy");
   emit timeSet(time_text);
}

void mainWindow::showHideRectangle(bool isChecked)
{
    emit isVisible(isChecked);
}

void mainWindow::openFile(QString filePath)
{
    QFile file(QUrl(filePath).toLocalFile());
    if(!file.open(QFile::ReadOnly | QFile::Text)) {
        return;
    }

    QString text = file.readAll();
    file.close();
    emit readText(text);

}

void mainWindow::getTextField(QString text)
{
    textField = text;

}

void mainWindow::writeFile(QString filepath)
{
    QFile file(QUrl(filepath).toLocalFile());

    if(!file.open(QFile::WriteOnly | QFile::Text)) {
        return;
    }
    QTextStream out(&file);
    out << textField;
    file.flush();
    file.close();
}
