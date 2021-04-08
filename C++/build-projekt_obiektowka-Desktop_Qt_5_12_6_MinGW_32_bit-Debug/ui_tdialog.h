/********************************************************************************
** Form generated from reading UI file 'tdialog.ui'
**
** Created by: Qt User Interface Compiler version 5.12.6
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_TDIALOG_H
#define UI_TDIALOG_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QTextEdit>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_TDialog
{
public:
    QLabel *label;
    QTextEdit *textEdit;
    QLabel *label_2;
    QTextEdit *textEdit_2;
    QPushButton *pushButton_6;
    QPushButton *pushButton_7;
    QWidget *layoutWidget;
    QVBoxLayout *verticalLayout;
    QPushButton *pushButton;
    QPushButton *pushButton_2;
    QPushButton *pushButton_3;
    QPushButton *pushButton_4;
    QPushButton *pushButton_5;
    QPushButton *pushButton_8;

    void setupUi(QDialog *TDialog)
    {
        if (TDialog->objectName().isEmpty())
            TDialog->setObjectName(QString::fromUtf8("TDialog"));
        TDialog->resize(646, 477);
        TDialog->setStyleSheet(QString::fromUtf8("\n"
"background-color: rgb(255, 242, 140);"));
        label = new QLabel(TDialog);
        label->setObjectName(QString::fromUtf8("label"));
        label->setGeometry(QRect(0, 230, 361, 241));
        textEdit = new QTextEdit(TDialog);
        textEdit->setObjectName(QString::fromUtf8("textEdit"));
        textEdit->setGeometry(QRect(0, 0, 211, 31));
        textEdit->setStyleSheet(QString::fromUtf8("background-color: rgb(255, 255, 255);"));
        label_2 = new QLabel(TDialog);
        label_2->setObjectName(QString::fromUtf8("label_2"));
        label_2->setGeometry(QRect(70, 120, 121, 81));
        textEdit_2 = new QTextEdit(TDialog);
        textEdit_2->setObjectName(QString::fromUtf8("textEdit_2"));
        textEdit_2->setGeometry(QRect(40, 60, 121, 31));
        textEdit_2->setStyleSheet(QString::fromUtf8("background-color: rgb(71, 255, 92);"));
        pushButton_6 = new QPushButton(TDialog);
        pushButton_6->setObjectName(QString::fromUtf8("pushButton_6"));
        pushButton_6->setGeometry(QRect(350, 40, 121, 61));
        pushButton_6->setStyleSheet(QString::fromUtf8("background-color: rgb(255, 255, 255);"));
        pushButton_7 = new QPushButton(TDialog);
        pushButton_7->setObjectName(QString::fromUtf8("pushButton_7"));
        pushButton_7->setGeometry(QRect(480, 280, 121, 61));
        pushButton_7->setStyleSheet(QString::fromUtf8("background-color: rgb(255, 255, 255);"));
        layoutWidget = new QWidget(TDialog);
        layoutWidget->setObjectName(QString::fromUtf8("layoutWidget"));
        layoutWidget->setGeometry(QRect(480, 40, 77, 141));
        verticalLayout = new QVBoxLayout(layoutWidget);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        verticalLayout->setContentsMargins(0, 0, 0, 0);
        pushButton = new QPushButton(layoutWidget);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));
        pushButton->setStyleSheet(QString::fromUtf8("background-color: rgb(255, 255, 255);"));

        verticalLayout->addWidget(pushButton);

        pushButton_2 = new QPushButton(layoutWidget);
        pushButton_2->setObjectName(QString::fromUtf8("pushButton_2"));
        pushButton_2->setStyleSheet(QString::fromUtf8("background-color: rgb(255, 255, 255);"));

        verticalLayout->addWidget(pushButton_2);

        pushButton_3 = new QPushButton(layoutWidget);
        pushButton_3->setObjectName(QString::fromUtf8("pushButton_3"));
        pushButton_3->setStyleSheet(QString::fromUtf8("background-color: rgb(255, 255, 255);"));

        verticalLayout->addWidget(pushButton_3);

        pushButton_4 = new QPushButton(layoutWidget);
        pushButton_4->setObjectName(QString::fromUtf8("pushButton_4"));
        pushButton_4->setStyleSheet(QString::fromUtf8("background-color: rgb(255, 255, 255);"));

        verticalLayout->addWidget(pushButton_4);

        pushButton_5 = new QPushButton(layoutWidget);
        pushButton_5->setObjectName(QString::fromUtf8("pushButton_5"));
        pushButton_5->setStyleSheet(QString::fromUtf8("background-color: rgb(255, 255, 255);"));

        verticalLayout->addWidget(pushButton_5);

        pushButton_8 = new QPushButton(TDialog);
        pushButton_8->setObjectName(QString::fromUtf8("pushButton_8"));
        pushButton_8->setGeometry(QRect(490, 200, 91, 51));
        pushButton_8->setStyleSheet(QString::fromUtf8("background-color: rgb(255, 255, 255);"));
        QWidget::setTabOrder(pushButton, pushButton_2);
        QWidget::setTabOrder(pushButton_2, pushButton_3);
        QWidget::setTabOrder(pushButton_3, pushButton_4);
        QWidget::setTabOrder(pushButton_4, pushButton_5);
        QWidget::setTabOrder(pushButton_5, textEdit);

        retranslateUi(TDialog);

        QMetaObject::connectSlotsByName(TDialog);
    } // setupUi

    void retranslateUi(QDialog *TDialog)
    {
        TDialog->setWindowTitle(QApplication::translate("TDialog", "Dialog", nullptr));
        label->setText(QString());
        textEdit->setHtml(QApplication::translate("TDialog", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'MS Shell Dlg 2'; font-weight:600;\">Witaj w Quizie o Lublinie</span></p></body></html>", nullptr));
        label_2->setText(QString());
        textEdit_2->setHtml(QApplication::translate("TDialog", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'MS Shell Dlg 2'; font-size:11pt; font-weight:600;\">WYNIK TO:</span></p></body></html>", nullptr));
        pushButton_6->setText(QApplication::translate("TDialog", "Pokaz pytania", nullptr));
        pushButton_7->setText(QApplication::translate("TDialog", "Widok Lublina", nullptr));
        pushButton->setText(QApplication::translate("TDialog", "Pytanie_1", nullptr));
        pushButton_2->setText(QApplication::translate("TDialog", "Pytanie_2", nullptr));
        pushButton_3->setText(QApplication::translate("TDialog", "Pytanie_3", nullptr));
        pushButton_4->setText(QApplication::translate("TDialog", "Pytanie_4", nullptr));
        pushButton_5->setText(QApplication::translate("TDialog", "Pytanie_5", nullptr));
        pushButton_8->setText(QApplication::translate("TDialog", "Wyjscie", nullptr));
    } // retranslateUi

};

namespace Ui {
    class TDialog: public Ui_TDialog {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_TDIALOG_H
