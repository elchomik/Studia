/********************************************************************************
** Form generated from reading UI file 'trzeci.ui'
**
** Created by: Qt User Interface Compiler version 5.12.6
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_TRZECI_H
#define UI_TRZECI_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QLabel>

QT_BEGIN_NAMESPACE

class Ui_trzeci
{
public:
    QLabel *label;

    void setupUi(QDialog *trzeci)
    {
        if (trzeci->objectName().isEmpty())
            trzeci->setObjectName(QString::fromUtf8("trzeci"));
        trzeci->resize(400, 300);
        label = new QLabel(trzeci);
        label->setObjectName(QString::fromUtf8("label"));
        label->setGeometry(QRect(0, 0, 401, 311));

        retranslateUi(trzeci);

        QMetaObject::connectSlotsByName(trzeci);
    } // setupUi

    void retranslateUi(QDialog *trzeci)
    {
        trzeci->setWindowTitle(QApplication::translate("trzeci", "Dialog", nullptr));
        label->setText(QString());
    } // retranslateUi

};

namespace Ui {
    class trzeci: public Ui_trzeci {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_TRZECI_H
