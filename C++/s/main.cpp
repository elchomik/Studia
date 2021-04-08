#include <iostream>
#include <typeinfo>
using namespace std;
class Zwierze{
protected:
string Imie;
int glod=0;
int zmeczenie=0;
int pragnienie=0;
int humor=0;
public:
static int ilosc;

    Zwierze(string imie="Jan"){
    this->Imie=Imie;

    }
    void ustaw_imie(string Imie);
    const string naLancuch();
    virtual string DajRodzajZwierzecia()const{
    return "Zwierzatko ";
    }
};
void Zwierze::ustaw_imie(string Imie){
this->Imie=Imie;
}
const string Zwierze::naLancuch(){
    cout<<"Glod zwierzecia to "<<glod<<endl;
    cout<<"Humor zwierzecia to "<<humor<<endl;
    cout<<"Zmecznie zwierzecia to "<<zmeczenie<<endl;
    cout<<"Pragnienie zwierzecia to "<<pragnienie<<endl;
return DajRodzajZwierzecia() + Imie;
}

class FunkcjeZyciowe{
public:
   virtual void Jedz(int iloscpozywienia)=0;
    virtual void Pij(int iloscwody)=0;
    virtual void spij(int czas)=0;
    virtual void bawsie(int czas)=0;
};

class Pies: public Zwierze,public FunkcjeZyciowe
{
public:
    Pies(string imie_zwierzaka,string imie_psa):Zwierze(imie_zwierzaka){
    imie_psa=imie_zwierzaka;
    }
    void Szczekaj(){
        cout<<"Hau Hau "<<endl;
    }
    void DajLape(){
    cout<<"Pies daje lape "<<endl;
    }
     string DajRodzajZwierzecia() const {
    return " Pies ";
    }
    void Jedz(int iloscpozywienia);
    void Pij(int iloscwody);
    void spij(int czas);
    void bawsie(int czas);
};
void Pies::Jedz(int iloscpozywienia){
glod=glod-7;
}
void Pies::Pij(int iloscwody){
pragnienie=pragnienie-8;
}
void Pies::spij(int czas){
zmeczenie=zmeczenie-10;
humor=humor-9;
}
void Pies::bawsie(int czas){
if(czas>10)
{
        glod=glod+5;
        pragnienie=pragnienie+56;
        humor=humor+6;
        zmeczenie=3*zmeczenie;
}
if(czas<10)
{
        glod=glod+3;
        pragnienie*=2;
        humor*=0.56;
        zmeczenie*=0.87;
}
}
class Kot:public Zwierze,public FunkcjeZyciowe
{
public:
    Kot(string imie):Zwierze(imie){}
    void Jedz(int iloscpozywienia);
    void Pij(int iloscwody);
    void spij(int czas);
    void bawsie(int czas);
    void miaucz(){
    cout<<"Miau Miau "<<endl;
    }
    void myjsie(){
    cout<<"Kot sie myje "<<endl;
    }
    string DajRodzajZwierzecia()const{
    return " Kot ";
    }
};
void Kot::Jedz(int iloscpozywienia){
glod=glod-5;
}
void Kot::Pij(int iloscwody){
pragnienie=pragnienie-134;
}
void Kot::spij(int czas){
zmeczenie=zmeczenie-104;
humor=humor-94;
}
void Kot::bawsie(int czas){
if(czas>10)
{
        glod=glod+5;
        pragnienie=pragnienie+56;
        humor=humor+6;
        zmeczenie=3*zmeczenie;
}
if(czas<10)
{
        glod=glod+3;
        pragnienie*=2;
        humor*=0.56;
        zmeczenie*=0.87;
}
}
int main()
{
    Pies p5("Bury","34");
    Kot cat("Kitku");
    FunkcjeZyciowe& funkcja=cat;
    p5.ustaw_imie("Bronia");
    p5.bawsie(14);
    cout<<p5.naLancuch()<<endl;
    p5.Jedz(15);
    cout<<p5.naLancuch()<<endl;
    p5.Pij(45);
    cout<<p5.naLancuch()<<endl;
    p5.spij(34);
    cout<<p5.naLancuch()<<endl;
return 0;
}


