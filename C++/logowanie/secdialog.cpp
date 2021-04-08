#include "secdialog.h"
#include "ui_secdialog.h"
#include <QPixmap>
SecDialog::SecDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::SecDialog)
{
    ui->setupUi(this);
   QPixmap pix(":/img/img/pingwin-maly.jpg");
   ui->label->setPixmap(pix.scaled(382,282,Qt::KeepAspectRatio));
}

SecDialog::~SecDialog()
{
    delete ui;
}

void SecDialog::on_pushButton_clicked()
{
    hide();
    trzeci *trojka=new trzeci(this);
    trojka->show();

}
