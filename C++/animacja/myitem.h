#ifndef MYITEM_H
#define MYITEM_H
#include <QGraphicsItem>
#include <QGraphicsScene>
#include <QPainter>

class myitem: public QGraphicsItem
{
public:
    myitem();
    QRectF boundingRect() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget = nullptr);
protected:
    void advance(int phase);
private:
    qreal angle;
    qreal speed;
    void Docollison();
};

#endif // MYITEM_H
