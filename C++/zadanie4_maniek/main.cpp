#include <iostream>
#include <cstdlib>
using namespace std;

class Tablica2d{
int wysokosc;
int szerokosc;
string nazwa;
int *wsk;
public:
    Tablica2d(int w,int s,string n):wysokosc(w),szerokosc(s),nazwa(n)
    {
        wysokosc=w;
        szerokosc=s;
        nazwa=n;
        wsk=new int[szerokosc*wysokosc];
        cout<<"Wywolano konstruktor "<<endl;
    }
    ~Tablica2d(){
    delete []wsk;
    cout<<"Wywolano destruktor "<<endl;
    }

    Tablica2d(const Tablica2d& tablica)
    {
        wysokosc=tablica.wysokosc;
        szerokosc=tablica.szerokosc;
        nazwa=tablica.nazwa;
        wsk=tablica.wsk;
        cout<<"Wywolano konstruktor kopiujacy "<<endl;
    }
    void zmien_nazwe();
    void ustaw_element(int,int,int);
    const void odczytaj(int wie,int kol){
        cout<<"Element o parametrach "<<wie<<","<<kol<< " = "<<wsk[wysokosc*szerokosc+kol]<<endl;
    }
    Tablica2d dodaj(const Tablica2d& dodawana) const;
    Tablica2d mnoz(const Tablica2d& mnozona) const;
    ostream& wyswietl(ostream& strumien) const;
};

void Tablica2d::zmien_nazwe()
{
    string nowa;
    cout<<"Podaj nowa nazwe tablicy "<<endl;
    cin>>nowa;
    nazwa=nowa;
}

void Tablica2d::ustaw_element(int wys,int kol,int wart)
{
    wsk[wys*szerokosc+kol]=wart;
}

Tablica2d Tablica2d::dodaj(const Tablica2d& dodawana) const
{
    if(wysokosc!=dodawana.wysokosc || szerokosc!=dodawana.szerokosc){
    cout<<"Dodawanie nie jest wykonalne "<<endl;
}
    else
        {
            Tablica2d wynik(wysokosc,szerokosc,"Wynik dodawania");
                for(int i=0;i<wysokosc;i++){
                    for(int j=0;j<szerokosc;j++){
                        wynik.wsk[i*szerokosc+j]=wsk[i*szerokosc+j]+dodawana.wsk[i*szerokosc+j];
                                                                                                }
                                                                                                    }
            return wynik;
        }
}

Tablica2d Tablica2d::mnoz(const Tablica2d& mnozona) const
{
    if(szerokosc!=mnozona.szerokosc)
        {
            cout<<"Nie dozwowlone mnozenie takich macierzy "<<endl;
        }
    else
    {
        Tablica2d wynik_m(wysokosc,mnozona.szerokosc,"Wynik mnozenia");
        wynik_m.wsk[0,0]=0;
                for(int i=0;i<wysokosc;i++){
                    for(int j=0;j<mnozona.szerokosc;j++){
                        for(int k=0;k<szerokosc;k++){
                    wynik_m.wsk[i*mnozona.szerokosc+j]=(wynik_m.wsk[i*mnozona.szerokosc+j]+(wsk[i*szerokosc+k]*mnozona.wsk[k*szerokosc+j]));
                        }
                            }
                            }
        return wynik_m;
    }
}

ostream& Tablica2d::wyswietl(ostream& strumien) const
{
    strumien<<internal<<nazwa<<endl;
        for(int i=0;i<wysokosc;i++){
            for(int j=0;j<szerokosc;j++){
                strumien<<wsk[i*szerokosc+j]<<"\t";
                                                    }
                                                    strumien<<endl;
                                                                    }
    return strumien;
}



int main()
{

    Tablica2d tab1(2,2,"Tablica1");
    Tablica2d tab2(2,2,"Tablica2");
    int value1,value2;
    for(int i=0;i<2;i++){
        for(int j=0;j<2;j++){
            cout<<"Wprowadz wartosc elementu ["<<i<<","<<j<<"] dla obu tablic"<<endl;
            cin>>value1>>value2;
            tab1.ustaw_element(i,j,value1);
           tab2.ustaw_element(i,j,value2);
        }
    }
    for(int i=0;i<2;i++){
        for(int j=0;j<2;j++){
cout<<"Wartosc elementu ["<<i<<","<<j<<"] "<<endl;
            tab1.odczytaj(i,j);
           tab2.odczytaj(i,j);
        }
    }

    Tablica2d wynik=tab1.dodaj(tab2);
    Tablica2d wynik_m=tab1.mnoz(tab2);
    tab1.zmien_nazwe();
    tab1.wyswietl(cout)<<endl;
    tab2.wyswietl(cout)<<endl;
    wynik.wyswietl(cout)<<endl;
    wynik_m.wyswietl(cout)<<endl;
    return 0;
}
