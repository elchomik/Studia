/****************************************************************************
** Meta object code from reading C++ file 'tdialog.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../projekt_obiektowka/tdialog.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'tdialog.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_TDialog_t {
    QByteArrayData data[12];
    char stringdata0[227];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_TDialog_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_TDialog_t qt_meta_stringdata_TDialog = {
    {
QT_MOC_LITERAL(0, 0, 7), // "TDialog"
QT_MOC_LITERAL(1, 8, 22), // "on_label_linkActivated"
QT_MOC_LITERAL(2, 31, 0), // ""
QT_MOC_LITERAL(3, 32, 4), // "link"
QT_MOC_LITERAL(4, 37, 21), // "on_pushButton_clicked"
QT_MOC_LITERAL(5, 59, 23), // "on_pushButton_2_clicked"
QT_MOC_LITERAL(6, 83, 23), // "on_pushButton_3_clicked"
QT_MOC_LITERAL(7, 107, 23), // "on_pushButton_4_clicked"
QT_MOC_LITERAL(8, 131, 23), // "on_pushButton_5_clicked"
QT_MOC_LITERAL(9, 155, 23), // "on_pushButton_6_clicked"
QT_MOC_LITERAL(10, 179, 23), // "on_pushButton_7_clicked"
QT_MOC_LITERAL(11, 203, 23) // "on_pushButton_8_clicked"

    },
    "TDialog\0on_label_linkActivated\0\0link\0"
    "on_pushButton_clicked\0on_pushButton_2_clicked\0"
    "on_pushButton_3_clicked\0on_pushButton_4_clicked\0"
    "on_pushButton_5_clicked\0on_pushButton_6_clicked\0"
    "on_pushButton_7_clicked\0on_pushButton_8_clicked"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_TDialog[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    1,   59,    2, 0x08 /* Private */,
       4,    0,   62,    2, 0x08 /* Private */,
       5,    0,   63,    2, 0x08 /* Private */,
       6,    0,   64,    2, 0x08 /* Private */,
       7,    0,   65,    2, 0x08 /* Private */,
       8,    0,   66,    2, 0x08 /* Private */,
       9,    0,   67,    2, 0x08 /* Private */,
      10,    0,   68,    2, 0x08 /* Private */,
      11,    0,   69,    2, 0x08 /* Private */,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void TDialog::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<TDialog *>(_o);
        Q_UNUSED(_t)
        switch (_id) {

        case 1: _t->on_pushButton_clicked(); break;
        case 2: _t->on_pushButton_2_clicked(); break;
        case 3: _t->on_pushButton_3_clicked(); break;
        case 4: _t->on_pushButton_4_clicked(); break;
        case 5: _t->on_pushButton_5_clicked(); break;
        case 6: _t->on_pushButton_6_clicked(); break;
        case 7: _t->on_pushButton_7_clicked(); break;
        case 8: _t->on_pushButton_8_clicked(); break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject TDialog::staticMetaObject = { {
    &QDialog::staticMetaObject,
    qt_meta_stringdata_TDialog.data,
    qt_meta_data_TDialog,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *TDialog::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *TDialog::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_TDialog.stringdata0))
        return static_cast<void*>(this);
    return QDialog::qt_metacast(_clname);
}

int TDialog::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 9)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 9;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
