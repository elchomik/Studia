/********************************************************************************
** Form generated from reading UI file 'scd.ui'
**
** Created by: Qt User Interface Compiler version 5.12.6
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_SCD_H
#define UI_SCD_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QPushButton>

QT_BEGIN_NAMESPACE

class Ui_SCD
{
public:
    QPushButton *pushButton;

    void setupUi(QDialog *SCD)
    {
        if (SCD->objectName().isEmpty())
            SCD->setObjectName(QString::fromUtf8("SCD"));
        SCD->resize(400, 300);
        pushButton = new QPushButton(SCD);
        pushButton->setObjectName(QString::fromUtf8("pushButton"));
        pushButton->setGeometry(QRect(110, 90, 111, 81));

        retranslateUi(SCD);

        QMetaObject::connectSlotsByName(SCD);
    } // setupUi

    void retranslateUi(QDialog *SCD)
    {
        SCD->setWindowTitle(QApplication::translate("SCD", "Dialog", nullptr));
        pushButton->setText(QApplication::translate("SCD", "PushButton", nullptr));
    } // retranslateUi

};

namespace Ui {
    class SCD: public Ui_SCD {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_SCD_H
