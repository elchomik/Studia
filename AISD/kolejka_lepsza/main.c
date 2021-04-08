#include <stdio.h>
#include <stdlib.h>
struct el_FIFO
{
    int x;
    struct el_FIFO *nast;
};

struct FIFO
{
    struct el_FIFO *poczatek;
    struct el_FIFO *koniec;
    int zlicz;
};

struct FIFO *dodaj(struct FIFO *kolejka, int el)
{
    struct el_FIFO *new_el=(struct el_FIFO *)malloc(sizeof(struct el_FIFO));
    new_el->x=el;
    new_el->nast=NULL;
    if(kolejka->koniec==NULL)
    {
        kolejka->poczatek=new_el;
        kolejka->koniec=new_el;
    }
    else
    {
        kolejka->koniec->nast=new_el;
        kolejka->koniec=new_el;
    }
    kolejka->zlicz++;
    return kolejka;
}

struct FIFO *zdejmij(struct FIFO *kolejka, int *el)
{
    struct el_FIFO *temp;
    *el=kolejka->poczatek->x;
    if(kolejka->poczatek!=kolejka->koniec)
    {
        temp=kolejka->poczatek->nast;
        free(kolejka->poczatek);
        kolejka->poczatek=temp;
    }
    else
    {
        free(kolejka->poczatek);
        kolejka->poczatek=NULL;
        kolejka->koniec=NULL;
    }
    kolejka->zlicz--;
    return kolejka;
}

struct FIFO *wynik(struct FIFO *kolejka)
{
    if(kolejka->poczatek==NULL)
    {
       printf("Kolejka jest pusta");
    }
    else
    {

        int dane;
        struct FIFO *kolejka_pom=(struct FIFO *)malloc(sizeof(struct FIFO));
        kolejka_pom->poczatek=NULL;
        kolejka_pom->koniec=NULL;
        printf("Poczatek kolejki\n");
        while(kolejka->poczatek!=NULL)
        {
            kolejka=zdejmij(kolejka,&dane);
            kolejka_pom=dodaj(kolejka_pom,dane);
            printf("%d\n",dane);
        }
        printf("Koniec kolejki\n");
        while(kolejka_pom->poczatek!=NULL)
        {
            kolejka_pom=zdejmij(kolejka_pom,&dane);
            kolejka=dodaj(kolejka,dane);
        }
    }
    return kolejka;
}
float srednia(struct FIFO* kolejka);
int szukaj(struct FIFO* kolejka,int szukana);

int main()
{
    int dane, wybor,el,szukana;
    float srednia2;
    struct FIFO *kolejka=(struct FIFO *)malloc(sizeof(struct FIFO));
    kolejka->poczatek=NULL;
    kolejka->koniec=NULL;
    kolejka->zlicz=NULL;
    do
    {
        system("cls");
        printf("Ilosc elementow kolejki to %d\n\n",kolejka->zlicz);
        wynik(kolejka);
        printf("\nMENU:\n");
        printf("1.Pusta kolejka\n");
        printf("2. Dodanie elementu\n");
        printf("3. Usuniecie elementu\n");
        printf("4. Wydruk\n");
        printf("5. Srednia z elementow w kolejce\n");
        printf("6. Wyszukanie elementu w kolejce\n");
        printf("7. Koniec programu\n");
        printf("Podaj swoj wybor \n");
        scanf("%d",&wybor);
        switch(wybor)
        {
            case 1:
                while(kolejka->poczatek)
                {
                    kolejka=zdejmij(kolejka,&dane);
                }
            break;
			case 2:
                printf("Wpisz liczbe(element)\n");
                scanf("%d", &dane);
                kolejka=dodaj(kolejka,dane);
			break;
			case 3:
                if(kolejka->poczatek!=NULL)
                {
                    kolejka=zdejmij(kolejka,&dane);
                    printf("Usunieto element <--> %d\n",dane);
                }
                else
                {
                    printf("Kolejka pusta\n");
                }
                getchar();
	        break;
	        case 4:
                kolejka=wynik(kolejka);
                getchar();
	        break;
	        case 5:
                srednia2=srednia(kolejka);
                printf("Srednia licz w kolejce wynosi %.2f\n",srednia2);
                getchar();
                break;
            case 6:
                printf("Podaj element szukany\n");
                scanf("%d",&szukana);
                if(szukaj(kolejka,szukana)==1) printf("Element jest w kolejce\n");
                if(szukaj(kolejka,szukana)==0) printf("Podanego elementu nie ma w kolejce\n");
                getchar();
                break;
	    }
	    getchar();
    }
    while(wybor!=7);
    return 0;
}
float srednia(struct FIFO* kolejka){
int suma=0;
float sr=1;
struct el_FIFO *el=(struct el_FIFO*)malloc(sizeof(struct el_FIFO*));
el=kolejka->poczatek;
while(el){
    suma+=el->x;
    el=el->nast;
}
sr=suma/kolejka->zlicz;

return sr;
}
int szukaj(struct FIFO *kolejka,int szukana){
struct el_FIFO* el=(struct el_FIFO*)malloc(sizeof(struct el_FIFO*));
el=kolejka->poczatek;
while(el){
    if(el->x==szukana) return 1;
    el=el->nast;

}
return 0;
}
