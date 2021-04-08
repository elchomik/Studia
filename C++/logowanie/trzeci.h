#ifndef TRZECI_H
#define TRZECI_H

#include <QDialog>

namespace Ui {
class trzeci;
}

class trzeci : public QDialog
{
    Q_OBJECT

public:
    explicit trzeci(QWidget *parent = nullptr);
    ~trzeci();

private:
    Ui::trzeci *ui;
};

#endif // TRZECI_H
