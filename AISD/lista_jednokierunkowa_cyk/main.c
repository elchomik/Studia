#include <stdio.h>
#include <stdlib.h>
struct el_lista {
    struct el_lista *nastepny;
    int x;
};
struct lista{
    struct el_lista *poczatek;
    struct el_lista *koniec;
};
struct lista *dodaj(struct lista *l, int el){ // dodanie elementu
    struct el_lista * new_el_lista =(struct el_lista*)malloc(sizeof(struct el_lista));
    new_el_lista->x=el;
    new_el_lista->nastepny=NULL;
    struct el_lista *tmp;
    if (l->koniec==NULL){
         l->poczatek=new_el_lista;
         l->koniec=new_el_lista;
    }
    else {
      l->koniec->nastepny=new_el_lista;
      new_el_lista->nastepny=l->poczatek;
      l->koniec=new_el_lista;
      l->koniec->nastepny=l->poczatek;
    }
}
struct lista* wydruk(struct lista *l){
   if(l->poczatek==NULL){
      printf("Lista pusta\n");
      return 0;
   }
   else{
      int i=1;
      struct el_lista *tmp1,*tmp2;
      tmp1=l->poczatek;
      tmp2=l->koniec;
      do {
         printf("%d elementem listy jest: %d\n",i,tmp1->x);
         i++;
         tmp1=tmp1->nastepny;
      } while (tmp2->nastepny!=tmp1);
      return 1;
   }
}
int oblicz(struct lista *l){
   int ile=0;
   if(l->poczatek==NULL){
      printf("Lista pusta\n");
      return 0;
   }
   else{
      int i=1;
      struct el_lista *tmp1,*tmp2;
      tmp1=l->poczatek;
      tmp2=l->koniec;
      do {
         if(tmp1->x%2 == 0 ){
            ile++;
         }
         tmp1=tmp1->nastepny;
      } while (tmp2->nastepny!=tmp1);
      return ile;
   }
}
int main()
{
   struct lista *l;
   l = (struct lista*)malloc(sizeof(struct lista));
   l->poczatek=NULL;
   l->koniec=NULL;
   int elem,miejsce,wybor,rob1,ile;
   do {
        system("cls");
        printf("1. Dodaj element na koniec listy\n");
        printf("2. Wyswietl elementy listy\n");
        printf("3. Oblicz ile jest parzystych elementow listy\n");
        printf("4. Zakoncz program\n");
        printf("Twoj wybor : \n");
        scanf("%d", &wybor);
        switch (wybor){
            case 1 : { // dodaj element do listy w wybranym miejscu
                printf("Podaj wartosc do dodania : \n");
                scanf("%d", &elem);
                dodaj(l,elem);
                break;
            }
            case 2 : { // pokaz elementy listy
               wydruk(l);
               system("PAUSE");
               getchar();
               break;
            }
            case 3 : {
               ile = oblicz(l);
               printf("Znaleziono %d parzystych elementow \n", ile);
               system("PAUSE");
               getchar();
               break;
            }
        }
   } while (wybor != 4);
   return 0;
}
