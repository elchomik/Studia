#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QMessageBox>
#include "scd.h"
#include <QDebug>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

}

MainWindow::~MainWindow()
{
    delete ui;
}

int zlicznik=0;

void MainWindow::on_pushButton_clicked()
{

    ui->label->setText("Dzien dobry");
    ui->pushButton->move(78,56);
    ui->horizontalSlider->showFullScreen();
    ui->progressBar->setValue(0);
    ui->horizontalSlider->setValue(0);
    ui->centralwidget->repaint();

}

void MainWindow::on_pushButton_2_clicked()
{
    int licznik=0;
   QMessageBox::StandardButton odpowiedz=
           QMessageBox::question(this,"to jest moja wiadmosc","Okienko",QMessageBox::Yes | QMessageBox::No | QMessageBox::Help);
   if(odpowiedz==QMessageBox::Yes){
       ui->pushButton_2->scroll(67,89);
       licznik=1;
       qDebug()<<licznik;
   }
   else if(odpowiedz==QMessageBox::No){
       ui->pushButton_2->setText("To jest nowy text");
       licznik=0;
       qDebug()<<licznik;
   }
   else{
       ui->pushButton_2->close();
   }

}

void MainWindow::on_pushButton_3_clicked()
{

   QMessageBox::StandardButton reply= QMessageBox::question(this,"Pytanie","UWAGA",
                                                       QMessageBox::Yes | QMessageBox::No);

   if(reply==QMessageBox::No){
     zlicznik++;
 }

 qDebug()<<"ILosc wystapien przycisku No wynosi"<<zlicznik;

}

void MainWindow::on_pushButton_4_clicked()
{
    QMessageBox::StandardButton close= QMessageBox::question(this,"Pytanie","Czy chcesz zamknac program",
                          QMessageBox::Yes| QMessageBox::No);
    if(close==QMessageBox::Yes){
        QApplication::quit();
    }
    if(close==QMessageBox::No){
        QApplication::beep();

    }
}

void MainWindow::on_pushButton_5_clicked()
{
    SCD drugieokno;
    drugieokno.setModal(true);
    drugieokno.exec();
    ui->pushButton_2->hide();
    ui->pushButton_3->hide();
    ui->pushButton_4->hide();
    ui->label->setText("Wywolano drugie okno");
    ui->progressBar->reset();

}





