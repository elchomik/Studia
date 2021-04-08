#include <stdio.h>
#include <stdlib.h>
struct el_listy{
int x;
struct el_listy *nastepny;
struct el_listy *poprzedni;
};

struct lista{
struct el_listy *poczatek;
struct el_listy *koniec;
//int zlicz;
};

struct lista *dodaj(struct lista *k,int pozycja,int el){
struct el_listy *new_el=(struct el_listy*)malloc(sizeof( struct el_listy));
new_el->x=el;
new_el->nastepny=NULL;
new_el->poprzedni=NULL;

if(k->poczatek==NULL){
    k->poczatek=new_el;
    k->koniec=new_el;
}
else{
    struct el_listy *tymczasowy;
    struct el_listy *tymczasowy2;
    tymczasowy=k->poczatek;

    for(int i=2;i<pozycja && tymczasowy->nastepny!=NULL;i++){
        tymczasowy=tymczasowy->nastepny;
    }

 if(tymczasowy->poprzedni==NULL && pozycja==1){
               tymczasowy->poprzedni=new_el;
               new_el->nastepny=tymczasowy;
               k->poczatek=new_el;
            }

else if(tymczasowy->nastepny!=NULL){
    tymczasowy2=tymczasowy->nastepny;
    tymczasowy->nastepny=new_el;
    tymczasowy2->poprzedni=new_el;
    new_el->poprzedni=tymczasowy;
    new_el->nastepny=tymczasowy2;
}
else{
    tymczasowy->nastepny=new_el;
    new_el->poprzedni=tymczasowy;
    k->koniec=new_el;
}
}
//k->zlicz++;
return k;
};

struct lista *usun(struct lista *k){
struct lista *tymczasowy;
if(k->poczatek!=NULL){
    if(k->poczatek==k->koniec){
        k->poczatek=NULL;
        k->koniec=NULL;
    }
    else{
        tymczasowy=k->koniec->poprzedni;
        free(k->koniec);
        k->koniec=tymczasowy;
        k->koniec->nastepny=NULL;

    }
}
//k->zlicz--;
return k;
};

struct lista *wyswietl(struct lista *k){
if(k->poczatek==NULL){
    printf("Lista jest pusta\n");
    return 0;
}
else{
    int i=1;
    struct el_listy *tymczasowy;
    tymczasowy=k->poczatek;
    while(tymczasowy!=NULL){
        printf(" %d element listy %d\n",i,tymczasowy->x);
        i++;
        tymczasowy=tymczasowy->nastepny;
    }
    return k;
}
};
float srednia(struct lista *k,int *il);
int szukaj(struct lista *k,int szukana);
int oblicz(struct lista *k);
int main()
{
struct lista *k=(struct lista *)malloc(sizeof(struct lista));
k->poczatek=NULL;
k->koniec=NULL;
//k->zlicz=NULL;
int wybor,element,pozycja,zmienna;
int szukana,parzysta,*il;
float sre;
do{
    system("cls");
   // printf("Ilosc elementow listy to %d\n\n",k->zlicz);
    wyswietl(k);
    printf("MENU\n");
    printf("1.Dodanie elementu\n");
    printf("2.Usuniecie elementu\n");
    printf("3.Wyswietlenie listy\n");
    printf("4.Srednia z liczb\n");
    printf("5.Poszukiwanie liczby w kolejce\n");
    printf("6.liczby parzyste\n");
    printf("7.Koniec programu\n");
    printf("Podaj swoj wybor\n");
    scanf("%d",&wybor);
    switch(wybor){
case 1:
    printf("Podaj element do wstawienia\n");
    scanf("%d",&element);
    printf("Podaj pozycje na ktora ma byc wstawiony\n");
    do{
        scanf("%d",&pozycja);
    }while(pozycja<=0);
    dodaj(k,pozycja,element);
    system("Pause");
    break;

    case 2:
        zmienna=usun(k);
        if(zmienna==k){
            printf("Element zostal usuniety z konca listy\n");
        }
        else{
            printf("Nie ma nic do usuwania\n");
        }
        system("Pause");
        break;
    case 3:
        wyswietl(k);
        system("Pause");
        break;
    case 4:
        sre=srednia(k,&il);
        printf("Srednia z elementow kolejki wynosi %.2f\n",sre);
        printf("Ilosc elementow w liscie to %d\n",il);
        getchar();
        break;
    case 5:
        printf("Podaj liczbe ktorej szukasz w liscie\n");
        scanf("%d",&szukana);
        if(szukaj(k,szukana)==1) printf("Podany element jest w liscie\n");
        if(szukaj(k,szukana)==0) printf("Podanego elementu nie ma w liscie\n");
        getchar();
        break;

    case 6:
        parzysta=oblicz(k);
        printf("W podanej liscie dwukierunkowej znajduje sie %d liczb parzystch\n",parzysta);
        getchar();
        break;
    }
    getchar();
    }
    while(wybor!=7);
    return 0;
}
float srednia(struct lista *k,int *il){
float suma=0;
int ile2=0;
*il=0;
float srednia2=1;
struct el_listy *el=(struct el_listy*)malloc(sizeof(struct el_listy*));
el=k->poczatek;
while(el){
    suma+=el->x;
    el=el->nastepny;
    ile2++;
}
srednia2=suma/ile2;
*il=ile2;
return srednia2;
}
int szukaj(struct lista *k,int szukana){
struct el_listy *el=(struct el_listy*)malloc(sizeof(struct el_listy*));
el=k->poczatek;
while(el){
    if(el->x==szukana)
        return 1;
    el=el->nastepny;
}
return 0;
}
int oblicz(struct lista *k){
int ile=0;
if(k->poczatek==NULL){
    printf("Nie ma zadnych elementow");
    return 0;
}
else{
    int i=1;
    struct el_listy *tmp;
    tmp=k->poczatek;
    while(tmp!=NULL){
        if(tmp->x%2==0){
            ile++;
    }
    tmp=tmp->nastepny;
    }
    return ile;
}
}
