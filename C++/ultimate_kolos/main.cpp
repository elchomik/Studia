#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;
class Statek{
string nazwa;
int liczba,wyszkolenie,wytrzymalosc;
public:
    Statek(string n,int l,int wysz,int wyt):nazwa(n),liczba(l),wyszkolenie(wysz),wytrzymalosc(wyt){

    }
    string get_nazwa(){
    return nazwa;
    }
    int get_liczba(){
    return liczba;
    }
    int get_wyszkolenie(){
    return wyszkolenie;
    }
    int get_wytrzymalosc(){
    return wytrzymalosc;
    }
    const void wyswietl();
    virtual double SilaOgnia(){
    return wyszkolenie*liczba;
    }
    virtual string KlasaOkretu(){
    return " Statek ";
    }
};
const void Statek::wyswietl(){
cout<<"Nazwa "<<KlasaOkretu()+nazwa<<endl;
cout<<"Liczba dzial "<<liczba<<endl;
cout<<"Wyszkolenie zalogi "<<wyszkolenie<<endl;
cout<<"Wytrzymalosc statku to "<<wytrzymalosc<<endl;
cout<<"Sila Ognia to "<<SilaOgnia()<<endl;
}
class HMRStatek:public Statek{
public:
    HMRStatek(string n,int w):Statek(n,15,w,150){}
    double SilaOgnia(){
    double m=75+rand()%25;
    m=m/100;
    if(m==1){
        cout<<"Zaloga wypoczeta "<<m<<endl;
        return get_wyszkolenie()*get_liczba()*m;
    }
    else if(m==0.75){
        cout<<"Zaloga jest zmeczona "<<m<<endl;
        return get_wyszkolenie()*get_liczba()*m;
    }
    else{
        cout<<"Zaloga moze byc "<<m<<endl;
        return get_wyszkolenie()*get_liczba()*m;
    }
    }
    string KlasaOkretu(){
    return " PEDAL 7 ";
    }
};

class BlackPearl:public Statek{
public:
    BlackPearl(string nazewka,int mariusz):Statek(nazewka,12,mariusz,160){}
    double SilaOgnia(){
    int m=rand()%2;
    if(m==1){
        cout<<"Zaloga najebana "<<m<<endl;
        return get_wyszkolenie()*get_liczba()*m;
    }
    else{
        cout<<"Zaloga jak twoj stary trzezwy"<<m<<endl;
        return get_wyszkolenie()*get_liczba()*m;
    }
    }
    string KlasaOkretu(){
    return " MARIUSZ 69 ";
    }
};
class Flota{
int n;
Statek *wsk;
public:
    Flota(int n1,Statek wsk[]){
    this->n=n1;
    this->wsk=wsk;
    }
    void wyswietl(){
    for(int i=0;i<n;i++){
        wsk[i].wyswietl();
    }
    }
    double SilaOgnia(){
    int pom=0;
    for(int i=0;i<n;i++){
        pom+=wsk[i].SilaOgnia();
    }
    return pom;
    }
    bool probasil(Flota &f){
    return (SilaOgnia()>f.SilaOgnia())? true:false;
    }

};
int main()
{
 srand(time(NULL));
 Statek st1("Mariusz",20,26,134);
 st1.wyswietl();
 HMRStatek s("R",34);
 s.wyswietl();
 BlackPearl s2("GT-V",767);
 s2.wyswietl();
HMRStatek dobrzy[6]={{"Zbychu",23},{"Zbychu1",2313},{"Zbychu2",233},{"Zbychu3",523},{"Zbychu4",6723},{"Zbychu5",376}};
BlackPearl chuje[6]={{"Chujew",12},{"Chujew1",45},{"Skurwol",34},{"Kurwinox",89},{"Chujeww",345},{"Zbychu4445",88}};
Flota f1(6,dobrzy);
Flota f2(6,chuje);
for(int i=0;i<6;i++){
    dobrzy[i].wyswietl();
    cout<<endl;
    chuje[i].wyswietl();
    cout<<endl;
}
//f1.wyswietl();
//f2.wyswietl();
cout<<endl;
if(f1.probasil(f2))
    cout<<"Zwyciestwo gwiezdnej floty"<<endl;
    else
        cout<<"SKurwole pedaly wygraly bo dupe swa daly "<<endl;


    return 0;
}
