#include <iostream>

using namespace std;
class Samochody{
public:
    string marka;
    string model;
    int rocznik;
    double przebieg;
    void wczytaj_dane(){
    cout<<"Podaj nowy samochod "<<endl;
    cout<<"Podaj marke samochodu "<<endl;
    cin>>marka;
    cout<<"Podaj model "<<endl;
    cin>>model;
    cout<<"Podaj rocznik "<<endl;
    cin>>rocznik;
    cout<<"Podaj przebieg (licznik nie byl krecony XD ) "<<endl;
    cin>>przebieg;
    }
    void wypisz_dane();
};
void Samochody:: wypisz_dane(){
cout<<"Marka to "<<marka<<" Model to "<<model<<" Rocznik "<<rocznik<<" Prebieg "<<przebieg<<endl;
}
int main()
{
    Samochody s1,s2;
    s1.wczytaj_dane();
    s1.wypisz_dane();
    cout<<endl;
    s2.wczytaj_dane();
    s2.wypisz_dane();
    return 0;
}
