#include <stdio.h>
#include <stdlib.h>
void czytaj(int n,int tab[]);
int liniowe(int n,int t,int tab[]);
int bisekcyjne(int n, int t,int tab[]);
int main()
{
    int n,t;
    printf("Podaj ilosc elementow tablicy\n");
    scanf("%d",&n);
    printf("Podaj element szukany\n");
    scanf("%d",&t);
    int tab[n];
    czytaj(n,tab);
    printf("\n");
    printf("///SORTOWANIE LINIOWE/////");
    printf("\n\n");
    int li=liniowe(n,t,tab);
    printf("Algorytm liniowy: element znajduje sie na miejscu %d ",li);
    int bisek=bisekcyjne(n,t,tab);
    printf("\n");
    printf("///SORTOWANIE BISEKCYJNE////");
    printf("\n\n");
    printf("Algorytm Bisekcyjny: element znajduje sie na miejscu %d ",bisek);
    printf("\n");
    return 0;
}
void czytaj(int n,int tab[]){
int i=0;
printf("Podaj pierwszy element do tablicy %d ",i);
scanf("%d",&tab[i]);
i++;
do{
    printf("Wczytaj element %d ",i);
    scanf("%d",&tab[i]);
    if(tab[i-1]<tab[i])
        i++;

else
    printf("ERROR: Wczytaj dane jeszcze raz\n");
}while(i<n);
}
int liniowe(int n, int t, int tab[]){
int i=0;
while(i<n && t!=tab[i]){
    i++;
}
if(t==tab[i]){
    return i;
}
else
    return -1;
}
int bisekcyjne(int n, int t, int tab[]){
int l=0,p=n;
while(p>l){
    int s=(l+p)/2;
    if(t>tab[s]){
        l=s+1;
    }
    else{
        p=s;
    }
}
if(t==tab[p]){
    return p;
}
else
    return -1;
}
