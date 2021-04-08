#include <iostream>
#include<stdlib.h>
#include<string>
using namespace std;
class Zwierze{
string imie;
public:
    static int licznik;
    Zwierze(string imie){
    this->imie=imie;
    licznik++;
    }
    void ustaw_imie(string imie){
    this->imie=imie;
    }
    const string naLancuch(){
    return imie;
    }
    static int ile_zwierzat(){
    return licznik;
    }

};
int Zwierze::licznik=0;
bool porownaj(Zwierze z1,Zwierze z2){
if(z1.naLancuch()==z2.naLancuch())
    return true;
    else
        return false;

}
int main()
{
    string imie;
    Zwierze z1=Zwierze("filemon");
    Zwierze z2=Zwierze("Bongo");
    cout<<"imie :"<<z1.naLancuch()<<endl;
    cout<<"imie :"<<z2.naLancuch()<<endl;
    z1.ustaw_imie("krowa");
    z2.ustaw_imie("Bleble");
    cout<<"imie :"<<z1.naLancuch()<<endl;
    cout<<"imie :"<<z2.naLancuch()<<endl;
    if(porownaj(z1,z2))
        cout<<"Prawda"<<endl;
        else
            cout<<"Falsz"<<endl;

    cout<<"Ilosc zwierzat to "<<Zwierze::ile_zwierzat()<<endl;
    return 0;
}
