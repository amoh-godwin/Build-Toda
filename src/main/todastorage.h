#ifndef TODASTORAGE_H
#define TODASTORAGE_H

#include <QObject>
#include <QFile>
#include <QString>

class TodaStorage : public QObject
{
    Q_OBJECT

public:
    explicit TodaStorage(QObject *parent = nullptr);

public slots:
    void update(QString contents) {
        t_save_contents = contents;
    }
private slots:
    void readFile();
    void saveFile(QString contents);

signals:
    void updated();

private:
    QFile file;
    QString t_fileName = "settings.settings";
    QString t_read_contents;
    QString t_save_contents;
};

#endif // TODASTORAGE_H
