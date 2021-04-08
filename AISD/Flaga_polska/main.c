#include <stdio.h>
#include <stdlib.h>
struct student {
float ocena;
int nr_indeksu;
};
void czytaj(int n,struct student *studenci);
float Flaga(int n,struct student *studenci);
void wydruk(int n,int n1,struct student *studenci);
int main()
{
 int n;
 struct student *studenci;
 studenci=(struct student*)malloc(n*sizeof(struct student));
 printf(" Podaj ilosc studentow\n");
 scanf("%d",&n);
 czytaj(n,studenci);
 if(n>0){
     int indeks=Flaga(n,studenci);
    wydruk(n,indeks,studenci);
 }
 else {
    printf("\nNie ma ujemnej liczby studentow\n");
 }
    return 0;
}

void czytaj(int n, struct student *studenci){

for(int i=0;i<n;i++){
    printf("Podaj nr indesku studenta\n");
    scanf("%d",&studenci[i].nr_indeksu);
    printf("Podaj ocene studenta\n");
    scanf("%f",&studenci[i].ocena);
}
}

float Flaga(int n,struct student *studenci){
int l=0,p=n-1;
int pom;
while(p>l){
    while(studenci[l].ocena>=3 && l<p)
        l++;
    while(studenci[p].ocena<3 && l<p)
        p--;
    if(p>l){
        pom=studenci[p].ocena;
        studenci[p].ocena=studenci[l].ocena;
        studenci[l].ocena=pom;

        pom=studenci[p].nr_indeksu;
        studenci[p].nr_indeksu=studenci[l].nr_indeksu;
        studenci[l].nr_indeksu=pom;
        l++;
        p--;
    }
}
if(studenci[p].ocena>=3)
    return p;
else
    return p-1;
}

void wydruk(int n,int indeks,struct student *studenci){
if(indeks==-1){
    printf("\n Nie zdali egzaminu\n");
    for( int i=0;i<n;i++){
        printf(" Studenci[%d] %.2f\n ",studenci[i].nr_indeksu,studenci[i].ocena);
    }
}
else if(indeks==n-1){
    printf("\n Zdali egzaminu\n");
    for( int i=0;i<=indeks;i++){
        printf(" Studenci[%d] %.2f \n",studenci[i].nr_indeksu,studenci[i].ocena);
    }
}
else{
    printf(" Zdali egzamin\n");
    for( int i=0;i<=indeks;i++){
        printf(" Studenci[%d] %.2f \n",studenci[i].nr_indeksu,studenci[i].ocena);
    }
    printf("\n Nie zdali egzaminu\n");
    for( int i=indeks+1;i<=n-1;i++){
        printf(" Studenci[%d] %.2f \n",studenci[i].nr_indeksu,studenci[i].ocena);
    }
}
}
