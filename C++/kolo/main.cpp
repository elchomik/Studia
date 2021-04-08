#include <iostream>

using namespace std;

class Punkt{
    protected:
double x,y;
string nazwa;
public:
    void wyswietl(){
    cout<<" nazwa "<<nazwa<<endl;
    cout<<" X: "<<x<<endl;
    cout<<" Y "<<y<<endl;
    }
    Punkt(string n="S",double x1=0,double y1=0){
    nazwa=n;
    x=x1;
    y=y1;
    }
};
class Kolo:public Punkt{// klasa kolo dziedziczy publicznie z klasy punkt
protected:
double r;
string nazwa;
public:
    void wyswietl(){
    cout<<"Kolo o nazwie "<<nazwa<<endl;
    cout<<"Srodek kola "<<endl;
    Punkt::wyswietl();
    cout<<"Promien "<<r<<endl;
    cout<<"Pole kola "<<3.14*r*r<<endl;
    }
    Kolo(string nk="Kolko",string np="S",double x1=0,double y1=0,double r1=3):Punkt(np,x1,y1)
    {
        nazwa=nk;
        r=r1;
    }
    void wczytaj(){
    cout<<"Podaj nazwe Kola "<<endl;
    cin>>nazwa;
    cout<<"Podaj wspolrzedne punktu "<<endl;
    cin>>Punkt::x;
    cout<<"Podaj Y "<<endl;
    cin>>Punkt::y;
    cout<<"Srodek kola to "<<endl;
    cin>>Punkt::nazwa;
    cout<<"Promien kola "<<endl;
    cin>>r;
    }

};
class Kula:public Kolo{
string nazwa;
public:
Kula(string nazwa_kuli="Kula dziedziczona",string nazwa_kola="Kolko",string np="S",double x1=0,double y1=0,double promien=1):Kolo(nazwa_kola,np,x1,y1,promien){
nazwa=nazwa_kuli;
}
void wyswietl();
};

void Kula::wyswietl(){
cout<<"Kula o nazwie "<<nazwa<<endl;
cout<<"Okrag o nazwie "<<endl;
cout<<Kolo::nazwa<<endl;
cout<<"Objetosc kuli "<<(4*3,14*r*r*r)/3<<endl;
}
int main()
{
    Kolo k1;
    k1.wyswietl();
    cout<<endl;
    //k1.wczytaj();
    //k1.wyswietl();

    Kula k2;
    k2.wyswietl();
    return 0;
}
