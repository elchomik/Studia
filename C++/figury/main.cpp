#include <iostream>
#include <math.h>
#include <vector>
using namespace std;

class punkt{
double x;
double y;
int n;
vector<double> xi;
vector<double> yi;
public:
    punkt(){};//konstruktor
    void wczytaj_wspolrzedne();
    void wyswietl_wspolrzedne();
    void ktora_cwiartka();
    void os_X();
    void os_Y();
};
void punkt::wczytaj_wspolrzedne(){
cout<<"Podaj ilosc punktow"<<endl;
cin>>n;
for(int i=0;i<n;i++){
    cout<<"Wspolrzedna punktu x: ["<<i<<"]  ";
    cin>>x;
    xi.push_back(x);
    cout<<"Wspolrzedna punktu y: ["<<i<<"]  ";
    cin>>y;
    yi.push_back(y);
}
}

void punkt::wyswietl_wspolrzedne(){
for(int i=0;i<n;i++){
    cout<<"Wspolrzedne punktu p ["<<i<<"] "<<xi[i]<<" "<<yi[i]<<endl;
}
}
void punkt::ktora_cwiartka(){
for(int i=0;i<n;i++){
    if(xi[i]<0 && yi[i]<0){
        cout<<"III cwiartka "<<endl;
    }
    else if(xi[i]<0 && yi[i]>0){
        cout<<"II cwiartka "<<endl;
    }
    else if(xi[i]>0 && yi[i]<0){
        cout<<"IV cwiartka "<<endl;
    }
    else if(xi[i]>0 && yi[i]>0){
        cout<<"I cwiartka "<<endl;
    }

}
}
void punkt::os_X(){
for(int i=0;i<n;i++){
    if(xi[i]==0)
        cout<<"Punkt lezy na Osi Y "<<endl;
}
}
void punkt::os_Y(){
for(int i=0;i<n;i++){
    if(yi[i]==0)
        cout<<"Punkt lezy na Osi X"<<endl;
}
}
class kwadrat::punkt{
double x,y;
int n;
vector<
};
int main()
{
    int n;
    double x,y;
    vector<double> xi,yi;
    punkt Punkt=punkt();
    Punkt.wczytaj_wspolrzedne();
    cout<<endl;
    Punkt.wyswietl_wspolrzedne();
    cout<<endl;
    Punkt.ktora_cwiartka();
    cout<<endl;
    Punkt.os_X();
    cout<<endl;
    Punkt.os_Y();
    return 0;
}
