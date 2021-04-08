#include <stdio.h>
#include <stdlib.h>
struct wspolrzedne{
int x;
int y;
};
void czytaj(int n,struct wspolrzedne *punkty);
float Flaga_Francuska(int n,int *indeks,int *indeks1,struct wspolrzedne *punkty);
void wyswietl(int n,int indeks,int indeks1,struct wspolrzedne *punkty);
int main()
{
    int n,indeks,indeks1;
    struct wspolrzedne *punkty;
    punkty=(struct wspolrzedne*)malloc(n*sizeof(struct wspolrzedne));
    printf(" Podaj ilosc punktow\n");
    scanf("%d",&n);
    czytaj(n,punkty);
    Flaga_Francuska(n,&indeks,&indeks1,punkty);
    wyswietl(n,indeks,indeks1,punkty);
    return 0;
}
void czytaj(int n,struct wspolrzedne *punkty){
for(int i=0;i<n;i++){
    printf("Podaj wspolrzedne punkty x nr %d\n",i);
    scanf("%d",&punkty[i].x);
    printf("Podaj wspolrzedne punkty y nr %d\n",i);
    scanf("%d",&punkty[i].y);
}
}
float Flaga_Francuska(int n, int *indeks ,int *indeks1,struct wspolrzedne *punkty){
int n1=-1,n2=0,n3=n,pom,pom1;
while(n3>n2){
    pom=punkty[n2].x;
    pom1=punkty[n2].y;
    if(pom==0 || pom1==0){
        n1=n1+1;
        punkty[n2].x=punkty[n1].x;
        punkty[n1].x=pom;

        punkty[n2].y=punkty[n1].y;
        punkty[n1].y=pom1;
        n2=n2+1;
    }
    else if((pom<0 && pom1>0)||(pom>0 && pom1<0) ){
        n2=n2+1;
    }
    else{
        n3=n3-1;
        punkty[n2].x=punkty[n3].x;
        punkty[n3].x=pom;

        punkty[n2].y=punkty[n3].y;
        punkty[n3].y=pom1;
    }
}
*indeks=n1;
*indeks1=n2;
}
void wyswietl(int n,int indeks,int indeks1,struct wspolrzedne *punkty){
if(indeks>=0){
    printf("\nPunkty lezace na osiach \n");
    for(int i=0;i<=indeks;i++){
        printf("(%d,%d)\n",punkty[i].x,punkty[i].y);
    }
}
if(indeks1-indeks>1){
    printf("\nPunkty lezace w cwiartkach 2 i 4\n");
    for(int i=indeks+1;i<indeks1;i++){
        printf("(%d,%d)\n",punkty[i].x,punkty[i].y);
    }
}
if(n-indeks1>=1){
    printf("\nPunkty lezace w cwiartkach 1 i 3\n");
    for(int i=indeks1;i<n;i++){
        printf("(%d,%d)\n",punkty[i].x,punkty[i].y);
    }
}
}
