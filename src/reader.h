#ifndef READER_H
#define READER_H

#include <QDebug>
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QXmlStreamReader>
#include <QUrl>
#include <QString>
#include <QVariant>
#include <QTextCodec>

class Reader: public QObject
{
    Q_OBJECT
public:
    explicit Reader(QObject *parent = 0);
    ~Reader();
    Q_INVOKABLE void getRSS();

    struct Quote {
        quint32 Number;     // Номер цитаты
        QString Timestamp;  // Временной штамп
        QString Text;       // Текст цитаты
    };

private:
    QNetworkAccessManager* _access_manager;
    QStringList data;
signals:
    void buildModel(QVariant data);
public slots:
    void gotRss(QNetworkReply *pReply);
};

#endif // READER_H
