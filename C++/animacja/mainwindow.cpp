#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "myitem.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    scene= new QGraphicsScene(this);
    ui->graphicsView->setScene(scene);

    ui->graphicsView->setRenderHint(QPainter::Antialiasing);

    scene->setSceneRect(-200,-200,300,300);

    QPen mypen(Qt::red);

    QLineF TopLine(scene->sceneRect().topLeft(),scene->sceneRect().topRight());
     QLineF RightLine(scene->sceneRect().topLeft(),scene->sceneRect().bottomLeft());
      QLineF LeftLine(scene->sceneRect().topRight(),scene->sceneRect().bottomRight());
       QLineF DownLine(scene->sceneRect().bottomLeft(),scene->sceneRect().bottomRight());

       scene->addLine(TopLine,mypen);
       scene->addLine(RightLine,mypen);
       scene->addLine(LeftLine,mypen);
       scene->addLine(DownLine,mypen);

       int Itemcount=1;
       for(int i=0;i<Itemcount;i++){
           myitem *item= new myitem();
           scene->addItem(item);

       }
       timer=new QTimer(this);
       connect(timer,SIGNAL(timeout()),scene,SLOT(advance()));
       timer->start(1000);
}

MainWindow::~MainWindow()
{
    delete ui;
}

