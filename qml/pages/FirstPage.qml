/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    Component.onCompleted: reader.getRSS()

    SilicaListView {
        id: layout_list_view
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Цитатник рунета")
        }


        delegate: BackgroundItem {
            width: parent.width
            height: label_quote.height + topRow.height + Theme.paddingLarge +Theme.paddingLarge + separator_quotes.height

            Column {
                anchors.fill: parent
                anchors.margins: Theme.horizontalPageMargin
                spacing: Theme.paddingLarge

                Row {
                    id: topRow
                    width: parent.width
                    spacing: Theme.paddingLarge
                    Label {
                        id: label_quote_num
                        width: parent.width - Theme.itemSizeMedium - topRow.spacing
                        //verticalAlignment: Text.AlignVCenter
                        //horizontalAlignment: Text.AlignRight
                        font.bold: true
                        text: "Цитата №";


                    }
                }
                Label {
                    id: label_quote
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Theme.horizontalPageMargin
                    anchors.rightMargin: Theme.horizontalPageMargin
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    text: modelData
                }
                Separator {
                    id: separator_quotes
                    //anchors.verticalCenter: verticalCenter
                    //anchors.bottom: parent.bottom

                    horizontalAlignment: Text.AlignHCenter
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    color: Theme.secondaryHighlightColor
                }
            }
            /*
            Label {
                id: label_quote
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                text: modelData
            }
            Separator {
                id: separator_quotes
                //anchors.verticalCenter: verticalCenter
                //anchors.bottom: parent.bottom

                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                color: Theme.secondaryHighlightColor
            }
            */
        }
        VerticalScrollDecorator {

        }
        PullDownMenu {
            MenuItem {
                text: qsTr("Обновить")
                onClicked: reader.getRSS()
            }
        }

        PushUpMenu {
            MenuItem {
                text: qsTr("Предыдущая страница")
                onClicked: pageContainer.push(Qt.resolvedUrl("SecondPage.qml"))
            }
            MenuItem {
                text: qsTr("О программе")
                onClicked: pageContainer.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }
    }


    Connections {
        target: reader;
        onBuildModel:{
            layout_list_view.model = data
        }
    }
}


