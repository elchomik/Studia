#include <stdio.h>
#include <stdlib.h>
struct lista
{
   int x;
   struct lista *nast;
   struct lista *poprzedni;
};

struct lista* dodaj(struct lista *poczatek, int el);
void wydruk (struct lista *poczatek);
struct lista* usun(struct lista *poczatek, int el);

int main()
{
    int wyb,el;
    struct lista *poczatek=NULL;
    do{
    system("cls");
    printf("1.Wprowadz element\n");
    printf("2. Wyswietl liste\n");
    printf("3. Usun z listy\n");
    printf("4. Koniec\n");
    printf("Podaj sowj wybor\n");
    scanf("%d",&wyb);
    switch(wyb){
    case 1:
    printf("Podaj element\n");
    scanf("%d",&el);
    poczatek=dodaj(poczatek,el);
    getchar();
    break;
    case 2:
    wydruk(poczatek);
    getchar();
    break;
   case 3:
    printf("Podaj element do usuniecia\n");
    scanf("%d",&el);
    poczatek=usun(poczatek,el);
    getchar();
    break;
    }getchar();
    }
while(wyb!=4);
}
struct lista* dodaj(struct lista *poczatek, int el){
struct lista *newel=(struct lista*)malloc(sizeof(struct lista));
newel->x=el;
struct lista *tmp;
if(poczatek==NULL){
newel->nast=newel;
newel->poprzedni=newel;
poczatek=newel;
return poczatek;
}
else if(poczatek->nast==poczatek){
newel->nast=poczatek;
newel->poprzedni=poczatek;
poczatek->nast=newel;
poczatek->poprzedni=newel;
return newel;
}
else{
  tmp=poczatek;
  while(tmp->nast!=poczatek){
    tmp=tmp->nast;

  }
  newel->poprzedni=tmp;
  newel->nast=poczatek;
  poczatek->poprzedni=newel;
  tmp->nast=newel;
  return newel;
}
};
void wydruk(struct lista *poczatek){
    struct lista *tmp=poczatek;
   ;
if(poczatek==NULL){
    printf("PUSTA\n");
}
else if(poczatek==poczatek->nast){
    printf("ELEMENT TO %d\n",poczatek->x);
}
else{
         tmp=tmp->poprzedni;
    do{

        printf("ELEMENT TO %d\n",tmp->x);
        tmp=tmp->poprzedni;
    }while(tmp!=poczatek->poprzedni);
}
}
struct lista* usun(struct lista *poczatek, int el){
if(poczatek==NULL){
    printf("PUSTA\n");
    return poczatek;
}
else if(poczatek==poczatek->nast){
        if (poczatek->x==el){
    printf("CALA LISTA USUNIETA\n");
    free(poczatek);
    return 0;}
    else {printf("BRAK EL\n"); return poczatek;}
}
else{
    struct lista *tmp=poczatek;
    while(tmp->x!=el && tmp->nast!=poczatek){
        tmp=tmp->nast;
    }
    if(tmp->x==el){
        if (tmp==poczatek){
         poczatek->poprzedni->nast=poczatek->nast;
         poczatek->nast->poprzedni=poczatek->poprzedni;
         tmp=poczatek->nast;
         free(poczatek);
         return tmp;

        }
        else{
        tmp->poprzedni->nast=tmp->nast;
        tmp->nast->poprzedni=tmp->poprzedni;
        free(tmp);
        return poczatek;}
    }
    else {printf("BRAK EL\n"); return poczatek;}
}
};
