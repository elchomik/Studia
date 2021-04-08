#include <iostream>

using namespace std;
class Tablica2D{
int szerokosc,wysokosc;
string nazwa_tablicy;
int* wskaznik;
public:
    Tablica2D(int sz,int wys,string nazwa_tablicy){
    szerokosc=new sz;
    wysokosc=new wys;
    nazwa_tablicy=new nazwa_tablicy;
    wskaznik=new int[sz*wys]
    cout<<"Wywolanao konstruktor"<<endl;
    }
    Tablica2D(const &Tablica2D kopia):
        szerokosc(kopia.szerokosc),wysokosc(kopia.wysokosc),nazwa_tablicy(kopia.nazwa_tablicy){
        wskaznik=kopia.wskaznik;
        cout<<"Wywolano konstruktor kopiujacy"<<endl;
        };

        ~Tablica2D(){
        cout<<"Wywolano destruktor"<<endl;
        delete wskaznik[];
        }

    string zmiana_nazwy(string nazwa_tablicy){
    string nowa_nazwa;
    cout<<"Podaj nazwe tablicy"<<endl;
    cin>>nowa_nazwa;
    nazwa_tablicy=nowa_nazwa;
    return nazwa_tablicy;
        }
    void nadaj_wartosc(int kolumny,int wiersze,int wartosc);
    int czytaj(int kolumny,int wiersze)
};
Zwierze::void nadaj_wartosc(int kolumny,int wiersze,int wartosc){
    wartosc=wskaznik[kolumny*szerokosc+kolumny];
}
int main()
{

    return 0;
}
