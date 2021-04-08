#include <iostream>
#include <iomanip>
#include <string>
#include <cstdlib>
using namespace std;
 struct stan{
    string imie;
    int glod;
    int humor;
    int zmeczenie;
 };

void okresl_stan(stan *wsk_pies, stan *wsk_kot);

namespace pies {
    void baw_sie(int czas,stan *wsk_pies, stan *wsk_kot, int n1, int n2);
    void odpoczywaj(int czas, stan *wsk_pies, int n);
    void jedz(int ilosc, stan *wsk_pies, int n);
}

namespace kot {
    void baw_sie(int czas, stan *wsk_pies, stan *wsk_kot,int n1, int n2);
    void odpoczywaj(int czas, stan *wsk_kot,int n);
    void jedz(int ilosc, stan *wsk_kot,int n );
}



int main()
{
     stan *wsk_pies = new  stan[3];
     stan *wsk_kot = new  stan[3];
    cout << "Zabawa kotow i psow " <<endl;
    int wybor=0,czas=0,dzialanie=3,dzialanie2=3,wyborkota=3,wyborpsa=3;
    for (int i = 0 ; i < 3 ; i++){
        cout << "Podaj imie psa nr: " << i+1 <<endl;
        cin >> wsk_pies[i].imie;
        wsk_pies[i].glod = 0;
        wsk_pies[i].humor = 0;
        wsk_pies[i].zmeczenie = 0;
    }
    for (int i = 0 ; i < 3 ; i++){
        cout << "Podaj imie kota nr " << i+1 << std::endl;
        cin >> wsk_kot[i].imie;
        wsk_kot[i].glod = 0;
        wsk_kot[i].humor = 0;
        wsk_kot[i].zmeczenie = 0;
    }

    do {
        cout << "Wybierz dzialanie : 0 - zakoncz program, 1 - dzialanie z kotami, 2 - dzialanie z psami,3 - wyswietl stan zwierzat" <<endl;
        cin >> wybor;
        switch (wybor){
            case 0:
                break;
            case 1: {
                cout << "Wybierz kota : 0 - " << wsk_kot[0].imie << " 1 - " << wsk_kot[1].imie << " 2 - " << wsk_kot[2].imie <<endl;
                cin >> wyborkota;
                cout << "Wybierz dzialanie : 0 - baw sie, 1 - nakarm, 2 - odpoczywaj" <<endl;
                cin >> dzialanie;
                switch (dzialanie){
                    case 0:{
                        cout << "Podaj czas czynnosci" <<endl;
                        cin >> czas;
                        cout << "Podaj ktoremu psu przeszkadza zabawa 0 - " << wsk_pies[0].imie << " 1 - " << wsk_pies[1].imie << " 2 -  " << wsk_pies[2].imie <<endl;
                        cin >> wyborpsa;
                        kot::baw_sie(czas,wsk_pies,wsk_kot,wyborpsa,wyborkota);
                        break;
                    }
                    case 1:{
                        cout << "Podaj czas czynnosci" <<endl;
                        cin >> czas;
                        kot::jedz(czas,wsk_kot,wyborkota);
                        break;
                    }
                    case 2:{
                        cout << "Podaj czas czynnosci" <<endl;
                        cin >> czas;
                        kot::odpoczywaj(czas,wsk_kot,wyborkota);
                        break;
                    }
                }
                break;
            }
            case 2: {
                cout << "Wybierz psa : 0 - " << wsk_pies[0].imie << " 1 - " << wsk_pies[1].imie << " 2 - " << wsk_pies[2].imie <<endl;
                cin >> wyborpsa;
                cout << "Wybierz dzialanie : 0 - baw sie, 1 - nakarm, 2 - odpoczywaj" <<endl;
                cin >> dzialanie2;
                switch (dzialanie2){
                    case 0:{
                        cout << "Podaj czas czynnosci" <<endl;
                        cin >> czas;
                        cout << "Podaj ktoremu kotu przeszkadza zabawa 0 - " << wsk_kot[0].imie << " 1 - " << wsk_kot[1].imie << " 2 -  " << wsk_kot[2].imie <<endl;
                        cin >> wyborkota;
                        pies::baw_sie(czas,wsk_pies,wsk_kot,wyborpsa,wyborkota);
                        break;
                    }
                    case 1:{
                        cout << "Podaj czas czynnosci" <<endl;
                        cin >> czas;
                        pies::jedz(czas,wsk_pies,wyborpsa);
                        break;
                    }
                    case 2:{
                        cout << "Podaj czas czynnosci" <<endl;
                        cin >> czas;
                        pies::odpoczywaj(czas,wsk_pies,wyborpsa);
                        break;
                    }
                }
                break;
            }
            case 3: {
                okresl_stan(wsk_pies,wsk_kot);
                break;
            }
        }
    }  while (wybor!=0);
    delete[] wsk_kot;
    delete[] wsk_pies;
    return 0;
}

void kot::baw_sie(int czas, stan *wsk_pies, stan *wsk_kot, int n1 , int n2){
    cout << wsk_kot[n2].imie << " sie bawi" << endl;
    wsk_kot[n2].zmeczenie-=czas;
    wsk_kot[n2].humor+=czas;
    wsk_kot[n2].glod-=czas;
    cout << wsk_pies[n1].imie << " jest zly!" <<endl;
    wsk_pies[n1].humor--;
}
void pies::baw_sie(int czas, stan *wsk_pies, stan *wsk_kot, int n1, int n2){
    cout << wsk_pies[n1].imie << " sie bawi" <<endl;
    wsk_pies[n1].zmeczenie-=czas;
    wsk_pies[n1].humor+=czas;
    wsk_pies[n1].glod-=czas;
    cout << wsk_kot[n2].imie << " jest zly!" <<endl;
    wsk_kot[n2].humor--;
}
void kot::odpoczywaj(int czas,stan *wsk_kot,int n){
    cout << wsk_kot[n].imie << " odpoczywa" <<endl;
    wsk_kot[n].zmeczenie+=czas;
}
void pies::odpoczywaj(int czas,stan *wsk_pies,int n){
    cout << wsk_pies[n].imie << " odpoczywa" << endl;
    wsk_pies[n].zmeczenie+=czas;
}
void kot::jedz(int czas,stan *wsk_kot, int n){
    cout << wsk_kot[n].imie << " je" <<endl;
    wsk_kot[n].glod+=czas;
}
void pies::jedz(int czas,stan *wsk_pies, int n){
    cout << wsk_pies[n].imie << " je" <<endl;
    wsk_pies[n].glod+=czas;
}
void okresl_stan(stan *wsk_pies, stan *wsk_kot){
    for (int i = 0 ; i < 3 ; i++){
        cout << wsk_pies[i].imie << " :" <<endl;
        cout << "Glod : " << wsk_pies[i].glod << " " << "Zmeczenie : " << wsk_pies[i].zmeczenie << " " << "Humor : " << wsk_pies[i].humor <<endl;
    }
    for (int i = 0 ; i < 3 ; i++){
        cout << wsk_kot[i].imie << " :" <<endl;
        cout << "Glod : " << wsk_kot[i].glod << " " << "Zmeczenie : " << wsk_kot[i].zmeczenie << " " << "Humor : " << wsk_kot[i].humor <<endl;
    }
}

