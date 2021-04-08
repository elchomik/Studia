#ifndef SCD_H
#define SCD_H

#include <QDialog>

namespace Ui {
class SCD;
}

class SCD : public QDialog
{
    Q_OBJECT

public:
    explicit SCD(QWidget *parent = nullptr);
    ~SCD();

private slots:
    void on_pushButton_clicked();

private:
    Ui::SCD *ui;
};

#endif // SCD_H
