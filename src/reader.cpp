#include "reader.h"

/**
 * @brief Конструктор Reader
 * @param parent
 */
Reader::Reader(QObject *parent)
{
    _access_manager = new QNetworkAccessManager(this);
    connect(_access_manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(gotRss(QNetworkReply*)));
}

/**
 * @brief Деструктор Reader
 */
Reader::~Reader()
{
    delete _access_manager;
}


/**
 * @brief Reader::getRSS Функция запускает получение XML страницы с цитатами
 */
void Reader::getRSS()
{
    QUrl url("http://bash.im/rss/");
    _access_manager->get(QNetworkRequest(url));
}


/**
 * @brief Reader::gotRss Слот, вызывающийся при окончании получения данных XML
 * @param pReply
 */
void Reader::gotRss(QNetworkReply *pReply) {
    QTextCodec *codec = QTextCodec::codecForName("Windows-1251");
    QString sResponse = codec->toUnicode(pReply->readAll());
    QXmlStreamReader xmlReader(sResponse);
    quint16 iCounter = 0;
    while (!xmlReader.atEnd()) {
        xmlReader.readNext();
        if (xmlReader.tokenType() == QXmlStreamReader::StartElement) {
            if (xmlReader.name() == "description") {
                iCounter++;
                if (iCounter == 1) continue;
                xmlReader.readNext();
                data.append(xmlReader.text().toString());

            }
        }
    }
    emit buildModel(QVariant::fromValue(data));
    //delete codec;

}

