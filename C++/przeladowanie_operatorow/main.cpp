#include <iostream>
#include <cstdlib>
using namespace std;

class punkt{
int x,y;
string nazwa;
public:
    punkt();
    ~punkt();
    punkt(int,int,string);
    static int ile;
    static void wyswietl_ile(){
        cout<<"Ile punktow "<<ile<<endl;
    }
    void wyswietl();
    punkt dodajpunkty(punkt &p);
    punkt operator+(punkt &p);
};
int punkt::ile=0;
punkt::punkt(){
cout<<"Tworze sobie punkcik "<<endl;
ile++;
}
punkt::punkt(int a,int b,string n):x(a),y(b),nazwa(n){
cout<<"Tworze sobie punkt"<<endl;
ile++;
}
punkt::~punkt(){
cout<<"Usuwam sobie punkt "<<endl;
ile--;
}
punkt punkt::dodajpunkty(punkt &p){
punkt pomocniczy;
pomocniczy.x=x+p.x;
pomocniczy.y=y+p.y;
pomocniczy.nazwa=nazwa+p.nazwa;
return pomocniczy;
}
punkt punkt::operator+(punkt &p){
punkt pomocniczy;
pomocniczy.x=x+p.x;
pomocniczy.y=y+p.y;
pomocniczy.nazwa=nazwa+pomocniczy.nazwa;
return pomocniczy;
}
void punkt::wyswietl(){
cout<<nazwa<<" ( "<<x<<" , "<<y<<" ) "<<endl;
}
int main()
{
    punkt::wyswietl_ile();
   punkt p1(2,3,"Azor");
   punkt p2(3,5,"Debil");
   punkt p3;
   p3=p1+p2;
   p3.wyswietl();
   p3=p1.dodajpunkty(p2);
   p3.wyswietl();
   punkt::wyswietl_ile();
    return 0;
}
