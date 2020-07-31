#ifndef DOWNLOADLISTMODEL_H
#define DOWNLOADLISTMODEL_H

#include <QAbstractListModel>

enum DOWNLOAD_STATUS
{
    DOWNLOADING,
    DONE,
    PAUSE,
    ERROR
};
struct Download
{
    QString deviceName = "";
    QString channel = "";
    QString dateStart = "";
    QString dateStop = "";
    DOWNLOAD_STATUS downloadStatus;
    int downloadPercent = 0;
};

class DownloadListModel : public QAbstractListModel
{
    Q_OBJECT
public:

    enum ROW_NAME
    {
        DEVICE_NAME = Qt::UserRole + 1,
        CHANNEL,
        DATE_START,
        DATE_STOP,
        DOWNLOAD_STATUS,
        DOWNLOAD_PERCENT
    };

    explicit DownloadListModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex & = QModelIndex()) const override;
    int columnCount(const QModelIndex & = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void resetModel();
    Q_INVOKABLE void pauseDownload (int downloadIndex);
    Q_INVOKABLE void deleteDownloadFromList(int downloadIndex);
    Q_INVOKABLE void clearDownloadList();

private:
    QList<Download> downloadList;
};

#endif // DOWNLOADLISTMODEL_H
