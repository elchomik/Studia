#include <cstdlib>
#include <iostream>
#include <ios>
#include <iomanip>
#include <vector>
using namespace std;
void dec_to_oct(int liczba, string napis);
void dec_to_hex(int liczba, string napis);

void dec_to_oct(int liczba, string napis,vector<int> wektor){
    while(cin>>liczba && napis!="koniec")
        wektor.push_back(liczba);
    for(int i=0;i<wektor.size();i++){
    cout<<showbase<<oct<<wektor[i]<<endl;
    }
}

void dec_to_hex(int liczba, string napis,vector<int> wektor){
   while(cin>>liczba&& napis!="koniec")
        wektor.push_back(liczba);
    for(int i=0;i<wektor.size();i++){
    cout<<showbase<<hex<<wektor[i]<<endl;
    }

}
int main()
{
    int liczba,wybor;
    string napis;
    vector<int> wektor;
    cout<<"MENU"<<endl;
    cout<<"1 Zamiana z dziesiatkowego na szesnastkowy\n";
    cout<<"2 Zamiana z dziesiatkowego na osemkowy\n";
    cout<<"Jesli chcesz zakonczyc wczytywanie liczb wpisz slowo koniec"<<endl;
    cout<<"Twoj wybor\n";
    cin>>wybor;
    switch(wybor){
case 1:
    dec_to_hex(liczba,napis,wektor);
    break;
case 2:
        dec_to_oct(liczba,napis,wektor);
    break;
    }
    return 0;
}
