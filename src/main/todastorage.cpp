#include <QFile>
#include <QDir>
#include "todastorage.h"

TodaStorage::TodaStorage(QObject *parent):
    QObject(parent)
{
}

void TodaStorage::readFile() {
    file.setFileName(t_fileName);
    QDir::setCurrent(".");

    if (QFile::exists(t_fileName)) {    // file exits
        file.open(QIODevice::ReadOnly);
        t_read_contents = QString(file.readAll());
        file.close();

    } else {    // if it doesn't exist create it

        file.open(QIODevice::ReadWrite);
        t_read_contents = "";
        file.write("");
        file.close();

    }


}

void TodaStorage::saveFile(QString contents) {
    file.open(QIODevice::WriteOnly);
    file.write(contents.toUtf8()); // convert QString to QByteArray
    file.close();
}
