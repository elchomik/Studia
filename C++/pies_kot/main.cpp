#include <iostream>

using namespace std;

namespace pies{
string imie="";
double humor=10;
double glod=10;
double zmeczenie=10;
void baw_sie(int);
void odpoczywaj(int);
void jedz(int);
}

namespace kot{
string imie="";
double humor=10;
double glod=10;
double zmeczenie=10;
void baw_sie(int);
void odpoczywaj(int);
void jedz(int);
}

void pies::baw_sie(int czas){
if(czas>0 && czas<2){
    pies::glod-=4;
    pies::humor+=5;
    pies::zmeczenie-=12;
}
else{
    pies::glod-=6;
    pies::humor+=7;
    pies::zmeczenie-=15;
}
cout<<"Humor psa "<<pies::humor<<"Glod psa "<<pies::glod<<"Zmeczenie psa "<<pies::zmeczenie<<endl;
}

void pies::odpoczywaj(int czas){
if(czas>0 && czas<2){
    pies::zmeczenie+=3;
}
else{
    pies::zmeczenie+=5;
}
cout<<"Zmeczenie psa "<<pies::zmeczenie<<endl;
}

void pies::jedz(int ilosc){
if(ilosc>0 && ilosc<5){
    pies::glod+=6;
}
else
    pies::glod+=8;
cout<<"Glod psa "<<pies::glod<<endl;
}


void kot::baw_sie(int czas){
if(czas>0 && czas<2){
    kot::glod-=4;
    kot::humor+=5;
    kot::zmeczenie-=12;
}
else{
    kot::glod-=6;
    kot::humor+=7;
    kot::zmeczenie-=15;
}
cout<<"Humor kota "<<kot::humor<<" Glod kota "<<kot::glod<<" Zmeczenie kota "<<kot::zmeczenie<<endl;
}

void kot::odpoczywaj(int czas){
if(czas>0 && czas<2){
    kot::zmeczenie+=3;
}
else{
    kot::zmeczenie+=5;
}
cout<<"Zmeczenie kota "<<kot::zmeczenie<<endl;
}

void kot::jedz(int ilosc){
if(ilosc>0 && ilosc<5){
    kot::glod+=6;
}
else
    kot::glod+=8;
cout<<"Glod kota "<<kot::glod<<endl;
}

int main()
{
    int ilosc,czas,wybor,wybor_2;
    do{
    cout<<"Wybierz swoje zwierzatko (1) Pies (2) Kot "<<endl;
    cin>>wybor;
    cout<<"Podaj ilosc czasu "<<endl;
    cin>>czas;
    cout<<"Podaj ilosc "<<endl;
    cin>>ilosc;

    if(wybor==1){
        cout<<"Podaj imie psa "<<endl;
        cin>>pies::imie;
        cout<<" Wybierz czynnosc"<<endl;
        cout<<"1. Odpoczywaj "<<endl;
        cout<<"2. Baw sie "<<endl;
        cout<<"3. Jedz "<<endl;
        cin>>wybor_2;
        switch(wybor_2){
            case 1:{
                pies::odpoczywaj(czas);
                break;
            }
            case 2: {
                pies::baw_sie(czas);
                break;
            }
            case 3: {
                    pies::jedz(ilosc);
                    break;
                }
        }
    }
    else if(wybor==2){
        cout<<"Podaj imie kota "<<endl;
        cin>>kot::imie;
        cout<<" Wybierz czynnosc"<<endl;
        cout<<"1. Odpoczywaj "<<endl;
        cout<<"2. Baw sie "<<endl;
        cout<<"3. Jedz "<<endl;
        cin>>wybor_2;
        switch(wybor_2){
            case 1:{
                kot::odpoczywaj(czas);
                break;
            }
            case 2: {
                kot::baw_sie(czas);
                break;
            }
            case 3: {
                    kot::jedz(ilosc);
                    break;
                }
        }
    }} while(wybor!=0);
    return 0;
}
