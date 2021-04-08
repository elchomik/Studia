#include "myitem.h"

myitem::myitem()
{
    angle=(qrand()%360);
    setRotation(angle);
    speed=5;
    int startX=0;
    int startY=0;
    if(qrand()%1){
        startX=qrand()%200;
        startY=qrand()%200;
    }
    else
    {
        startX=qrand()%-100;
        startY=qrand()%-100;
    }
    setPos(mapToParent(startX,startY));


}

QRectF myitem::boundingRect() const
{
    return QRectF(0,0,50,50);
}

void myitem::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget)
{
    QRectF rec=boundingRect();
    QBrush brush(Qt::green);
    if(scene()->collidingItems(this).isEmpty())
    {
    brush.setColor(Qt::blue);
    }
    else
    {
        brush.setColor(Qt::red);
        Docollison();
    }
    painter->fillRect(rec,brush);
    painter->drawRect(rec);
}

void myitem::advance(int phase)
{
    if(!phase) return;
    QPointF location=this->pos();
    setPos(mapToParent(0,-speed));

}

void myitem::Docollison()
{
// get a new position

    if(qrand()%1){
        setRotation(rotation()+180+(qrand()%10));

    }
    else{
        setRotation(rotation()+180+(qrand()%10));

    }

  QPointF newpoint=mapToParent(-(boundingRect().width()),(-boundingRect().width()+2));

  if(!scene()->sceneRect().contains((newpoint)))
  {
      newpoint=mapToParent(0,0);
  }
  else
  {
   setPos(newpoint);
  }
}
