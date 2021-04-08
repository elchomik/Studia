#include <iostream>
#include <ctime>
#include <cstdlib>
#include <assert.h>
#include <time.h>
using namespace std;

class Statek{
    string nazwa;
    int liczba_dzial;
    int wyszkolenie_zalogi;
    int wytrzymalosc;
public:
    Statek(){}
    Statek(string n, int l, int w, int wy ):nazwa(n),liczba_dzial(l),wyszkolenie_zalogi(w),wytrzymalosc(wy){

  }
  enum zmienna{SPRAWNY,NIESPRAWNY};
  zmienna w;
  bool Metoda(){
      if(w<=0)
        return NIESPRAWNY;
       //cout<<NIESPRAWNY<<endl;
      else
      return SPRAWNY;
        //cout<<SPRAWNY<<endl;

  }
  bool zamiana(){
  if(w<=0 && liczba_dzial>0){
    return SPRAWNY;
  }
  else{
    return NIESPRAWNY;
  }
  }
    string get_nazwa() const {
    return nazwa;
    }
    int get_liczba_dzial()const{
    return liczba_dzial;
    }
    int get_wyszkolenie_zalogi()const{
    return wyszkolenie_zalogi;
    }
    int get_wytrzymalosc()const{
    return wytrzymalosc;
    }

    void set_nazwa(string nazwa) {
        this->nazwa=nazwa;
    }

    void set_liczba_dzial(int liczba_dzial) {
        this->liczba_dzial=liczba_dzial;
    }
    void set_wyszkolenie(int wyszkolenie_zalogi) {
        this->wyszkolenie_zalogi=wyszkolenie_zalogi;
    }
    void set_wytrzymalosc(int wytrzymalosc) {
        this->wytrzymalosc=wytrzymalosc;
    }
    virtual double SilaOgnia(){
    //cout<<wyszkolenie_zalogi*liczba_dzial<<endl;
    return get_wyszkolenie_zalogi()*get_liczba_dzial();
    }
    virtual string KlasaOkretu() const {
    return " Statek ";
    }
    const void wyswietl() {
    cout<<"Nazwa "<<KlasaOkretu()+nazwa<<endl;
    cout<<"Liczba dzial "<<liczba_dzial<<endl;
    cout<<"Wyszkolenie "<<wyszkolenie_zalogi<<endl;
    cout<<"Wytzymalosc "<<wytrzymalosc<<endl;
   cout<<"Sila ognia to :"<<SilaOgnia()<<endl;
    }
};

class HMRStatek:public Statek{
public:
    HMRStatek(){}
    HMRStatek(string n1,int wysz1):Statek(n1,15,wysz1,160){
    }
    double SilaOgnia(){
    double m=75+rand()%25;
    m=m/100;
    if(m==1){
        cout<<"Zaloga wypoczeta "<<m<<endl;
    //cout<<wyszkolenie_zalogi*liczba_dzial*m<<endl;
    return static_cast<double>(1.4*get_wyszkolenie_zalogi()*get_liczba_dzial()*m);
    }
    else if(m==0.75){
    cout<<"Zaloga zmeczona "<<m<<endl;
    //cout<<wyszkolenie_zalogi*liczba_dzial*m<<endl;
    return static_cast<double>(get_wyszkolenie_zalogi()*get_liczba_dzial()*m*0.3);
    }
    else{
        cout<<"Zaloga zdolna do walki "<<m<<endl;
        //cout<<wyszkolenie_zalogi*liczba_dzial*m<<endl;
        return static_cast<double>(get_wyszkolenie_zalogi()*get_liczba_dzial()*m*0.65);
    }
    }
    string KlasaOkretu() const{
    return " HMR ";
    }
};
class BlackPearl:public Statek{
public:
    BlackPearl(){}
    BlackPearl(string n1,int wysz1):Statek(n1,12,wysz1,160){

    }

     double SilaOgnia(){
    double rum=1+rand()%2;
    cout<<"Wypili rumu "<<rum<<endl;
    if(rum==1){
        //cout<<0.2*wyszkolenie_zalogi*liczba_dzial*rum<<endl;
        return 0.2*get_wyszkolenie_zalogi()*get_liczba_dzial()*rum;
    }
    else
    return get_wyszkolenie_zalogi()*get_liczba_dzial()*2;
    }
    string KlasaOkretu() const{
    return " Black Pearl ";
    }
};
class Flota{
int ilosc;
Statek tablica[6];
public:
    Flota(){
    for(int i=0;i<6;i++){
        tablica[i]=Statek();
    }
    }
    Flota(int n,Statek tab[6]);
    double SilaOgnia();
    void wyswietl();
    bool probaSila(Flota &f){
    return (SilaOgnia()>f.SilaOgnia()?true:false);
    }

};
 Flota::Flota(int n,Statek tab[6]){
ilosc=n;
for(int i=0;i<n;i++){
        tablica[i]=tab[i];

}
}
double Flota::SilaOgnia(){
double sum=0;
for(int i=0;i<6;i++){
    sum+=tablica[i].SilaOgnia();
}
return sum;
}
void Flota::wyswietl(){
for(int i=0;i<6;i++){
    tablica[i].wyswietl();
}
}

int main()
{
    Statek s1("Maniek",2,10,3);
    srand(time(NULL));
    /*HMRStatek s[6]={{"M",1,7,13,"Mario",69},
    {"A",2,8,14,"Mar",70},
    {"N",3,9,15,"Mari",71},
    {"I",4,10,16,"kot",72},
    {"U",5,11,17,"Mg",73},
    {"S",6,12,18,"Mgdg",74}};

    BlackPearl s2[6]={{"Ju",6,7,8,"HUJet",783},
     {"Juru",9,10,11,"HUJy",2378},
      {"Juus",14,13,12,"HUJt",478},
       {"Jrus",15,16,17,"HUJew",578},
        {"Jus",116,711,811,"HUJe",678},
         {"Jurs",64,73,821,"HU",878}};

    */      HMRStatek s[6]={{"M",12},
    {"A",256},
    {"N",33},
    {"I",45},
    {"U",566},
    {"S",6664}};

        BlackPearl s2[6]={{"Ju",6},
     {"Juru",9},
      {"Juus",14},
       {"Jrus",15},
        {"Jus",116},
         {"Jurs",64}};
         Flota f1(6,s);
         Flota f2(6,s2);
         for(int i=0;i<6;i++){
        /* s[0].set_nazwa("hiphop");
         s[1].set_nazwa("m");
         s[2].set_nazwa("f");
         s[3].set_nazwa("gtf");
         s[4].set_nazwa("dope");
         s[5].set_nazwa("Gt");

          s[0].set_wyszkolenie(45);
         s[1].set_wyszkolenie(56);
         s[2].set_wyszkolenie(34);
         s[3].set_wyszkolenie(98);
         s[4].set_wyszkolenie(345);
         s[5].set_wyszkolenie(35);

         s2[0].set_nazwa("jd");
         s2[1].set_nazwa("Juice");
         s2[2].set_nazwa("Leh");
         s2[3].set_nazwa("Ziolo");
         s2[4].set_nazwa("Andzia");
         s2[5].set_nazwa("Bedi");

         s2[0].set_wyszkolenie(2);
         s2[1].set_wyszkolenie(32);
         s2[2].set_wyszkolenie(5);
         s2[3].set_wyszkolenie(89);
         s2[4].set_wyszkolenie(67);
         s2[5].set_wyszkolenie(56);
         */
            s[i].wyswietl();
            if(s[i].Metoda())
            cout<<"NIESPRAWNY"<<endl;
            else
                cout<<"SPRAWNY"<<endl;
                if(s[i].Metoda())
                    cout<<"Po zamianie stan jest SPRAWNY"<<endl;
                else cout<<"Po zamianie stan jest NIESPRAWNY"<<endl;
            cout<<endl;
            s2[i].wyswietl();
            if(s2[i].Metoda()!=0)
                cout<<"NIESPRAWNY"<<endl;
            else
            cout<<"SPRAWNY"<<endl;
               if(s2[i].Metoda())
                    cout<<"Po zamianie stan jest SPRAWNY"<<endl;
                else cout<<"Po zamianie stan jest NIESPRAWNY"<<endl;
            cout<<endl;
         }
         if(f1.probaSila(f2))
            cout<<"Zwyciestwo floty 1 "<<endl;
         else
            cout<<"Zwyciestwo floty 2 "<<endl;
         /*
 for(int i=0;i<6;i++){
    s[i].wyswietl();
 }
  for(int i=0;i<6;i++){
    s2[i].wyswietl();
 }
Flota flota1 (6,s);
Flota flota2 (6,s2);
flota1.wyswietl();
flota2.wyswietl();
    cout<<s1.get_nazwa()<<endl;
    cout<<s1.get_liczba_dzial()<<endl;
    cout<<s1.get_wyszkolenie_zalogi()<<endl;
    cout<<s1.get_wytrzymalosc()<<endl;
    s1.wyswietl();
    s2.wyswietl();
    cout<<s2.klasaOkretu()<<endl;
    s3.wyswietl();
    cout<<s3.klasaOkretu()<<endl;*/
    return 0;
}
