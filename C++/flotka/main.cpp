#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;
class Statek{
string nazwa;
int liczba;
int wyszkolenie;
int wytrzymalosc;
public:
    Statek(string n,int li,int wy,int w):nazwa(n),liczba(li),wyszkolenie(wy),wytrzymalosc(w){}
    string get_nazwa(){
        return nazwa;
    }
    int get_liczba(){
    return liczba;
    }
    int get_wyszkolenie(){
    return wyszkolenie;
    }
    int  get_wytrzymalosc(){
        return wytrzymalosc;
    }
    void set_nazwa(string nazwa){
    this->nazwa=nazwa;
    }
    void set_liczba(int liczba){
    this->liczba=liczba;
    }
    void set_wyszkolenie(int wyszkolenie){
    this->wyszkolenie=wyszkolenie;
    }
    void set_wytrzymalosc(int wytrzymalosc){
    this->wytrzymalosc=wytrzymalosc;
    }
    virtual double SilaOgnia(){
    return liczba*wyszkolenie;
    }
    virtual  string KlasaOkretu() const{
    return " Statek ";
    }
    const void wyswietl(){
    cout<<"Nazwa statku to "<<KlasaOkretu()+nazwa<<endl;
    cout<<"Liczba dzial to "<<liczba<<endl;
    cout<<"Wyszkolenie zalogi wynosi "<<wyszkolenie<<endl;
    cout<<"Wytrzymalosc kadluba to "<<wytrzymalosc<<endl;
    cout<<"Sila ognia to "<<SilaOgnia()<<endl;
    }
};

class HMRStatek:public Statek{
public:
    HMRStatek(string n,int wysz):Statek("St",12,5,150){
    }
    double SilaOgnia(int liczba,int wyszkolenie){
        srand(time(NULL));
    int zm=75+rand()%25;
    if(zm==100){
        cout<<"Zaloga trzezwa "<<zm<<endl;
        return zm*liczba*wyszkolenie;
    }
    else if(zm==75){
        cout<<"Zaloga jest nie zdolna "<<zm<<endl;
        return zm*liczba*wyszkolenie;
    }
    else{
        cout<<"Zaloga da rade "<<zm<<endl;
        return zm*liczba*wyszkolenie;
    }
    }
    string KlasaOkretu() const {
    return " HMRStatek ";
    }


};

class BlackPearl:public Statek{
public:
     BlackPearl(string n,int wysz):Statek("St",15,5,150){

    }
    double SilaOgnia(int liczba,int wyszkolenie){
        srand(time(NULL));
    double zm=rand()%2;
    if(zm==1){
        cout<<"Zaloga trzezwa "<<zm<<endl;
        return zm*liczba*wyszkolenie;
    }
    else if(zm==0){
        cout<<"Zaloga jest nie zdolna "<<zm<<endl;
        return zm*liczba*wyszkolenie;
    }
    else{
        cout<<"Zaloga da rade "<<zm<<endl;
        return zm*liczba*wyszkolenie;
    }
    }
    string KlasaOkretu() const {
    return " BlackPearl ";
    }


};
class Flota{
int ilosc;
Statek statki[6];
public:
    Flota(){
    for(int i=0;i<6;i++){
        statki[i]=Statek();
    }
    Flota(int n,Statek tablica[6]){
    ilosc=n;
    tablica[6]=statki[i];
    }
    void wyswietl(){
    for(int i=0;i<6;i++){
        statki[i].wyswietl();
    }
    double SilaOgnia(){
    double suma=0;
    for(int i=0;i<6;i++){
    suma+=statki[i].SilaOgnia();
    }
    return suma;
    }
    bool porownaj(Flota &f){
    return (SilaOgnia()>f.SilaOgnia()?true:false);
    }
    }
    }
};
int main()
{
    HMRStatek s1[6]={{"Maniek",5},{"Marek",56},{"Maciek",55},{"Kowal",57},{"Mikeal",58},{"Antio",67}};
    BlackPearl s2[6]={{"Arek",6},{"Jarek",34},{"Darek",23},{"Kanarek",32},{"oranek",33},{"Antoni",678}};
    for(int i=0;i<6;i++){
    s1[0].set_nazwa("Burek");
    s1[1].set_nazwa("Bieda");
    s1[2].set_nazwa("kolia");
    s1[3].set_nazwa("koza");
    s1[4].set_nazwa("korek");
    s1[5].set_nazwa("Lop");

     s1[0].set_wyszkolenie(65);
    s1[1].set_wyszkolenie(89);
    s1[2].set_wyszkolenie(98);
    s1[3].set_wyszkolenie(34);
    s1[4].set_wyszkolenie(23);
    s1[5].set_wyszkolenie(90);

    s2[0].set_nazwa("Krzysiu");
    s2[1].set_nazwa("Gdzie");
    s2[2].set_nazwa("Ty");
    s2[3].set_nazwa("Kurcze");
    s2[4].set_nazwa("Jestes");
    s2[5].set_nazwa("Debilu");

    s2[0].set_wyszkolenie(34);
    s2[1].set_wyszkolenie(2);
    s2[2].set_wyszkolenie(21);
    s2[3].set_wyszkolenie(38);
    s2[4].set_wyszkolenie(78);
    s2[5].set_wyszkolenie(99);


    s1[i].wyswietl();
    cout<<s1[i].SilaOgnia(12,13)<<endl;
    cout<<endl;
    s2[i].wyswietl();
    cout<<s2[i].SilaOgnia(2,5)<<endl;
    cout<<endl;
    }
    return 0;
}
