#include "downloadlistmodel.h"

DownloadListModel::DownloadListModel(QObject *parent)
{
    for (int i = 0; i < 10; i++)
    {
        Download download;
        download.deviceName = "Orest";
        download.channel = "30";
        download.dateStart = "29.07.2020";
        download.dateStop = "30.07.2020";
        download.downloadStatus = DOWNLOAD_STATUS::DOWNLOADING;
        download.downloadPercent = 20;
        downloadList.append(download);
    }
}

int DownloadListModel::rowCount(const QModelIndex &) const
{
    return downloadList.size();
}

int DownloadListModel::columnCount(const QModelIndex &) const
{
    return 1;
}

QVariant DownloadListModel::data(const QModelIndex &index, int role) const
{

    if (downloadList.size() <= index.row())
        return "";
    if  (1 <= index.column())
        return "";
    switch (role)
    {

    case int(ROW_NAME::DEVICE_NAME):
    {
        return downloadList.at(index.row()).deviceName;
    }

    case int(ROW_NAME::CHANNEL):
    {
        return downloadList.at(index.row()).channel;
    }

    case int(ROW_NAME::DATE_START):
    {
        return downloadList.at(index.row()).dateStart;
    }

    case int(ROW_NAME::DATE_STOP):
    {
        return downloadList.at(index.row()).dateStop;
    }

    case int(ROW_NAME::DOWNLOAD_STATUS):
    {
        switch (downloadList.at(index.row()).downloadStatus)
        {
        case int(DOWNLOAD_STATUS::DOWNLOADING):
        {
            return "Downloading";
        }
        case int(DOWNLOAD_STATUS::DONE):
        {
            return "Done";
        }
        case int(DOWNLOAD_STATUS::ERROR):
        {
            return "Error";
        }
        case int(DOWNLOAD_STATUS::PAUSE):
        {
            return "Pause";
        }
        }
    }

    case int(ROW_NAME::DOWNLOAD_PERCENT):
    {
        return downloadList.at(index.row()).downloadPercent;
    }

        return QVariant();
    }


}

QHash<int, QByteArray> DownloadListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ROW_NAME::DEVICE_NAME] = "DeviceName";
    roles[ROW_NAME::CHANNEL] = "Channel";
    roles[ROW_NAME::DATE_START] = "DateStart";
    roles[ROW_NAME::DATE_STOP] = "DateStop";
    roles[ROW_NAME::DOWNLOAD_STATUS] = "DownloadStatus";
    roles[ROW_NAME::DOWNLOAD_PERCENT] = "DownloadPercent";
    //    roles[Qt::DisplayRole] = "display";
    return roles;
}

void DownloadListModel::resetModel()
{
    beginResetModel();
    endResetModel();
}

void DownloadListModel::pauseDownload(int downloadIndex)
{
    for (int i = 0; i <=10; i++)
    {
        downloadList[downloadIndex].downloadPercent = i;
        auto modelIndex = index(downloadIndex, 0);
        emit QAbstractListModel::dataChanged(modelIndex, modelIndex, {ROW_NAME::DOWNLOAD_STATUS, ROW_NAME::DOWNLOAD_PERCENT});
    }
}

void DownloadListModel::clearDownloadList()
{
    downloadList.clear();
}

void DownloadListModel::deleteDownloadFromList(int downloadIndex)
{
    downloadList.removeAt(downloadIndex);
}
