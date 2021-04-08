#include <iostream>
#include <math.h>
using namespace std;

class Punkt{
public:
    string nazwa;
    double x,y;
public:
    Punkt(string,double,double);
    ~Punkt();
    void wyswietl();
};
Punkt::Punkt(string np="PUNKT",double a=4, double b=-6){
nazwa=np;
x=a;
y=b;
}
Punkt::~Punkt(){
cout<<"Zostal wywolany destruktor "<<endl;
}
void Punkt::wyswietl(){
cout<<"Nazwa punktu "<<nazwa<<"("<<x<<","<<y<<")"<<endl;
}

class Kwadrat:public Punkt{
string nazwa;
public:
    Kwadrat(string nk="Kwadrat",string np="A",double a=0, double b=0):Punkt(np,a,b){
    nazwa=nk;
    }
    void wyswietl(){
    cout<<"Nazwa Kwadratu to "<<nazwa<<endl;
    cout<<"Pole kwadratu 1 to "<<pow(x,2)<<endl;
    cout<<"Pole kwadratu 2 to "<<pow(y,2)<<endl;
    }

};
int main()
{
    Punkt p1("B",2,1),p2("A",1,3);
   cout<<"Pole kwadratu "<<sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2))<<endl;
    Kwadrat k1("Andrzej","A",4,6);
    k1.wyswietl();

    return 0;
}
