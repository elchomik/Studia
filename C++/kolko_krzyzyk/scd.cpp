#include "scd.h"
#include "ui_scd.h"
#include <QMessageBox>
SCD::SCD(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::SCD)
{
    ui->setupUi(this);
}

SCD::~SCD()
{
    delete ui;
}

void SCD::on_pushButton_clicked()
{
    QMessageBox::aboutQt(this,"Tytul Okienka");

}
