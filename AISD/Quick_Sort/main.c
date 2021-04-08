#include <stdio.h>
#include <stdlib.h>
int *czytaj(int *n,int *r);
int flaga(int n,int *tab);
int Podzial(int *tab,int l,int p);
void QuickSort(int *tab,int l,int p);
int Szukaj(int *tab,int indeks,int r);
int main()
{   int n=0,r=0,*tab,indeks=-1;
    tab= czytaj(&n,&r);
    if(n>0){
        indeks=flaga(n,tab);
        QuickSort(tab,0,indeks);
       int przedzial=Szukaj(tab,indeks,r);
        printf("\nTablica liczb\n");
        for(int i=0;i<n;i++){
            printf("TAB [%d] = [%d] \n",i,tab[i]);
        }
        printf(" Przedzial zawierajacy najwiecej liczb parzystych \n [%d,%d]\n",przedzial,przedzial+r);
    }
    else
        printf(" Przedzial nie moze byc ujemny\n");
    return 0;
}
int *czytaj(int *n, int *r)
{
    while(*n<=0)
    {
        printf("Podaj ilosc liczb:\n");
        scanf("%d", &*n);
        if(*n<=0)
        {
            printf("Ilosc elementow musi byc dodatnia\n");
        }
    }
    int i, *tab;
    tab=(int*)malloc(*n*sizeof(int));
    for(i=0;i<*n;i++)
    {
        printf("Tab [%d]: ", i);
        scanf("%d", &tab[i]);
    }
    while(*r<=0)
    {
        printf("Podaj dlugosc przedzialu: ");
        scanf("%d", &*r);
        if(*r<=0)
        {
        printf("Dlugosc przedzialu musi byc dodatnia.\n");
    }
    }
    return tab;
}
int flaga(int n,int *tab){
    int l=0,p=n-1;
    int pom;
    while(p>l){
    while((tab[l]%2==0) && (l<p))
        l++;
    while((tab[p]%2!=0) && (l<p))
        p--;
    if(p>l){
        pom=tab[p];
        tab[p]=tab[l];
        tab[l]=pom;
        l++;
        p--;
    }
    }
    if(tab[p]%2==0){
        return p;
    }
    else return p-1;
}
void QuickSort(int *tab,int l,int p){
    if(l<p){
        int z=Podzial(tab,l,p);
        QuickSort(tab,l,z);
        QuickSort(tab,z+1,p);
    }
}
int Podzial(int *tab,int l,int p){
int t,i,j,pom;
t=tab[l];
i=l;
j=p;
do {
        do{
            i++;
        }
    while((tab[i]<t) && (i<j));
    do{
        j--;
    }
    while((tab[i]>=t) && (i<j));
    if(j>i){
        pom=tab[i];
        tab[i]=tab[j];
        tab[j]=pom;
        i++;
        j--;
    }
    }
    while(j>i);

if(t>tab[i]){
    tab[l]=tab[i];
    tab[i]=t;
}
return i-1;
}

int Szukaj(int *tab,int indeks,int r){
int i=0,j=0;
int poczatek,koniec,ile_p,max=0,p_max=0;
int n=tab[indeks];
while(i<indeks){
   poczatek=tab[i];
   koniec=poczatek+r;
    ile_p=0;
    while((tab[i]<=koniec) && (i<indeks)){
        ile_p++;
        i++;
    }
    if(ile_p>max){
        max=ile_p;
        p_max=poczatek;
    }
}
return p_max;
}
