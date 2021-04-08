#include <stdio.h>
#include <stdlib.h>
#include <math.h>

struct el_LIFO
{
    int x;
    struct el_LIFO* nast;
};

struct LIFO
{
    struct el_LIFO *top;
    int zlicz;
};

struct el_LIFO* push(struct LIFO *stos, int el)
{
    struct el_LIFO *new_el_LIFO=(struct el_LIFO*)malloc(sizeof(struct el_LIFO));
    new_el_LIFO->x=el;
    new_el_LIFO->nast=stos->top;
    stos->top = new_el_LIFO;
    stos->zlicz++;
};

struct el_LIFO* pop(struct LIFO *stos)
{
    struct el_LIFO *temp;
    if(stos->top == NULL) printf("Nie mozna usunac zadnego elementu - stos jest pusty");
    else
    {
        printf("Usunieto element = %d\n", stos->top->x);
        temp=stos->top->nast;
        free(stos->top);
        stos-> top = temp;
        stos-> zlicz--;
    }
    getchar();
};

int top_el(struct LIFO *stos, int *el)
{
    if (stos->top!=NULL)
    {
        *el=stos->top->x;
        return 1;
    }
    else { return 0;}
}

struct LIFO* wyswietl (struct LIFO *stos)
{
    if (stos-> top == NULL) printf("Stos pusty\n");
    else
    {
        struct el_LIFO* el = (struct el_LIFO*)malloc(sizeof(struct el_LIFO));
        el = stos->top;
        while (el)
        {
            printf("%d\n", el->x);
            el = el->nast;
        }
        printf("\nwierzcholek = %d\n", stos->top->x);
    }

};
float srednia(struct LIFO *stos);
int sprawdz(struct LIFO *stos, int szukana);

int main()
{
    int wybor,wartosc,szukana;
    float sr;
    struct LIFO *stos = (struct LIFO*)malloc(sizeof(struct LIFO));
    stos->top = NULL;
    stos->zlicz =NULL;

    do
    {   printf("\nWcisnij dowlony klawisz\n");
        getchar();
        system("cls");
        printf("zlicz %d\n\n", stos->zlicz);
        printf("Elementy stosu\n");
        wyswietl(stos);
        printf("Menu\n");
        printf("1 Dodanie elementu do stosu\n");
        printf("2 Zdjecie elementu ze stosu\n");
        printf("3 Srednia i suma elementow na stosie\n");
        printf("4 Szukanie elementu na stosie\n");
        printf("5 Koniec dzialania programu\n");
        printf("Wpisz swoj wybor\n");
        scanf("%d", &wybor);
        switch(wybor){
        case 1:
        printf("Podaj wartosc elementu, ktory chcesz dodac na stos\n");
        scanf("%d",&wartosc);
        push(stos,wartosc);
        getchar();
        break;
        case 2:
            pop(stos);
            getchar();
            break;
        case 3:
            sr=srednia(stos)/stos->zlicz;
            if(sr!=0)
                printf("Srednia to %.2f\n",sr);
            else printf("Srednia wynosi 0\n");
            getchar();
            break;
        case 4: printf("Podaj wartosc szukanego elementu\n");
            scanf("%d",&szukana);
            if(sprawdz(stos,szukana)==0)
                printf("Podany element nie znajduje sie w stosie\n");
            if(sprawdz(stos,szukana)==1)
                printf("Podany element znajduje sie w stosie\n");
            getchar();
            break;
        case 5:
            free(stos);
            printf("Koniec\n");
            getchar();
            break;

        }}while(wybor!=5);


    return 0;
}

float srednia(struct LIFO *stos)
{
    float suma=0;
    if (stos-> zlicz !=NULL)
    {
        struct el_LIFO* el = (struct el_LIFO*)malloc(sizeof(struct el_LIFO));
        el = stos->top;
        while (el)
        {
            suma=suma+ el->x;
            el = el->nast;
        }
        printf("Suma %f\n", suma);
        return suma;
    }
    else return 0;
}

int sprawdz(struct LIFO *stos, int szukana)
{
    struct el_LIFO* el = (struct el_LIFO*)malloc(sizeof(struct el_LIFO));
    el = stos->top;
    while (el)
    {
        if (el->x == szukana) return 1;
        el = el->nast;
    }
    return 0;
}
