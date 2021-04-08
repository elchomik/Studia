#include "trzeci.h"
#include "ui_trzeci.h"

trzeci::trzeci(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::trzeci)
{
    ui->setupUi(this);
    int szerokosc=ui->label->width();
    int wysokosc=ui->label->height();
    QPixmap obraz(":/img/img/heroes.jpg");
    ui->label->setPixmap(obraz.scaled(szerokosc,wysokosc,Qt::KeepAspectRatio));
}

trzeci::~trzeci()
{
    delete ui;
}
