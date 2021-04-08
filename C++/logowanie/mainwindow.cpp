#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QMessageBox>
#include <QDebug>
#include <QPixmap>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    int w=ui->label_3->width();
    int h=ui->label_3->height();
    QPixmap picture(":/img/img/zero.jpg");
    ui->label_3->setPixmap(picture.scaled(w,h,Qt::KeepAspectRatio));
    ui->statusbar->addPermanentWidget(ui->label_4,1);
    ui->statusbar->addPermanentWidget(ui->progressBar,1);
}
int licz=0;

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_pushButton_clicked()
{
    QString username=ui->lineEdit->text();
    QString password=ui->lineEdit_2->text();
    if(username=="test" && password=="test"){
        QMessageBox::information(this,"Bank","Udalo sie uzyskac login do konta");
        hide();
        secDialog = new SecDialog(this);
        secDialog->show();
        licz++;
        qDebug()<<"Dostep udalo sie otrzymac za proba"<<licz;
    }
    else if((username!="test" || password!="test")&&licz>4){
        licz++;
        qDebug()<<"Nie udalo sie uzyskac dostepu w 3 probach";
         QApplication::quit();
    }
    else{
        ui->lineEdit->clear();
        ui->lineEdit_2->clear();
        int w=ui->label_3->width();
        int h=ui->label_3->height();
        QPixmap object(":/img/img/jeden.jpg");
        QPixmap object2(":/img/img/dwa.jpg");
        QPixmap object3(":/img/img/trzy.jpg");
        QPixmap object4(":/img/img/indeks.png");
        if(licz==1){
        ui->label_3->setPixmap(object.scaled(w,h,Qt::KeepAspectRatio));
        ui->statusbar->showMessage("Proba nie powiodla sie",1000);
        }
        else if(licz==2){
        ui->label_3->setPixmap(object2.scaled(w,h,Qt::KeepAspectRatio));
        ui->statusbar->showMessage("Proba nr 2 sie nie powiodla",1000);
        }
        else if(licz==3){
            ui->label_3->setPixmap(object3.scaled(w,h,Qt::KeepAspectRatio));
            ui->statusbar->showMessage("Proba numer 3 sie nie powiodla koncze gre",1000);
        }
        if(licz==4){
            ui->label_3->setPixmap(object4.scaled(w,h,Qt::KeepAspectRatio));
            ui->statusbar->showMessage("Koniec gry",1500);
        }

       // QMessageBox::warning(this,"Bank","Zla nazwa uzytkownika lub haslo");
        licz++;
    }
}
