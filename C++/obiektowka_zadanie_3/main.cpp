#include <iostream>
#include <math.h>
#include <ios>
#include <iomanip>
#include <string>
#include <sstream>
using namespace std;

struct pracownicy{
string imie;
string nazwisko;
int liczba_godzin;
double stawka;
string data_zatrudnienia;
};
void wczytaj(pracownicy *pracownik_1,int n){
    for(int i=0;i<n;i++){
    cout<<"Podaj imie pracownika"<<endl;
    cin>>pracownik_1[i].imie;
    cout<<"Podaj nazwisko pracownika"<<endl;
    cin>>pracownik_1[i].nazwisko;
    cout<<"Podaj liczbe godzin"<<endl;
    cin>>pracownik_1[i].liczba_godzin;
    cout<<"Podaj stawke"<<endl;
    cin>>pracownik_1[i].stawka;
    cout<<"Podaj date zatrudnienia"<<endl;
    cin>>pracownik_1[i].data_zatrudnienia;
    }
}
void wydruk(pracownicy *pracownik_1,int n){
    cout<<setw(12)<<left<<"Pracownik"<<setw(12)<<left<<"Imie"<<setw(13)<<left<<"Nazwisko"<<setw(13)<<left<<"Stawka/h"<<setw(13)<<left<<"Godziny"<<setw(14)<<left<<"Data przyjecia"<<endl;
    cout<<endl;
    for(int i=0;i<n;i++){
    cout<<setw(12)<<left<<i<<setw(12)<<left<<pracownik_1[i].imie<<setw(13)<<left<<pracownik_1[i].nazwisko<<setw(13)<<left<<pracownik_1[i].liczba_godzin
    <<setw(13)<<left<<pracownik_1[i].stawka<<setw(14)<<left<<pracownik_1[i].data_zatrudnienia<<endl;
    cout<<endl;
    }
}
void TO_string(pracownicy *pracownik_1, int n){
for(int i=0;i<n;i++){
    stringstream strumien;
    strumien<<setw(10)<pracownik_1[i].imie<<setw(10)<<pracownik_1[i].nazwisko<<setw(10)<<pracownik_1[i].liczba_godzin<<setw(10)<<pracownik_1[i].stawka<<setw(10)<<pracownik_1[i].data_zatrudnienia <<endl;
    cout<<strumien.str()<<endl;

}
}
int main()
{

    int n;
    cout<<"Podaj ilosc elementow"<<endl;
    cin>>n;
    pracownicy *pracownik_1=new pracownicy[n];
    wczytaj(pracownik_1,n);
    wydruk(pracownik_1,n);
    cout<<endl;
    TO_string(pracownik_1,n);
    delete pracownik_1;
    return 0;
}
