#include "reader.h"

Reader::Reader(QObject *parent)
{
    _access_manager = new QNetworkAccessManager(this);
    connect(_access_manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(gotRss(QNetworkReply*)));
}


Reader::~Reader()
{
    delete _access_manager;
}






void Reader::getRSS()
{
    QUrl url("http://bash.im/rss/");
    _access_manager->get(QNetworkRequest(url));
}





void Reader::gotRss(QNetworkReply *pReply)
{
    QTextCodec *codec = QTextCodec::codecForName("Windows-1251");
    QString sResponse = codec->toUnicode(pReply->readAll());
    QXmlStreamReader xmlReader(sResponse);

    xmlReader.readNext();
    while (!xmlReader.atEnd()) {
        xmlReader.readNext();
        if (xmlReader.tokenType() == QXmlStreamReader::StartElement) {
            if (xmlReader.name() == "description") {
                xmlReader.readNext();
                data.append(xmlReader.text().toString());
            }
        }

    }
    emit buildModel(QVariant::fromValue(data));
    //delete codec;

}

