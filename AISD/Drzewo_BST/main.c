#include <stdio.h>
#include <stdlib.h>
struct dowiazanie
{
    int k;
    struct dowiazanie *lewe;
    struct dowiazanie *prawe;
};
struct dowiazanie *minimum(struct dowiazanie *dowiazanie);

struct dowiazanie *nowe(int element)
{
    struct dowiazanie *tym=(struct dowiazanie *)malloc(sizeof(struct dowiazanie));
    tym->k=element;
    tym->lewe=tym->prawe=NULL;

    return tym;
}

struct dowiazanie *dodaj(int element, struct dowiazanie *root)
{
    if(root==NULL)
    {
        return nowe(element);
    }

    if(element<root->k)
    {
        root->lewe=dodaj(element, root->lewe);
    }
    else if(element>root->k)
    {
        root->prawe=dodaj(element, root->prawe);
    }

    return root;
};

void przeglad(struct dowiazanie *root)
{
    if(root!=NULL)
    {
        przeglad(root->lewe);
        printf("%d\n", root->k);
        przeglad(root->prawe);
    }
}

struct dowiazanie *wyszukaj(int w, struct dowiazanie *root)
{
    if(root==NULL||root->k==w)
    {
        return root;
    }
    else if(root->k<w)
    {
        return wyszukaj(w,root->prawe);
    }
    else
    {
        return wyszukaj(w,root->lewe);
    }
};

struct dowiazanie *kasuj(int element, struct dowiazanie *root)
{
    if(root==NULL)
    {
        return root;
    }
    if(element<root->k)
    {
        root->lewe=kasuj(element,root->lewe);
    }
    else if(element>root->k)
    {
        root->prawe=kasuj(element,root->prawe);
    }
    else
    {
        if(root->lewe==NULL)
        {
            struct dowiazanie *tym=root->prawe;
            free(root);
            return tym;
        }
        else if (root->prawe==NULL)
        {
            struct dowiazanie *tym=root->lewe;
            free(root);
            return tym;
        }
        struct dowiazanie *tym=minimum(root->prawe);

        root->k=tym->k;
        root->prawe=kasuj(tym->k,root->prawe);
    }
    return root;
}

struct dowiazanie *minimum(struct dowiazanie *dowiazanie)
{
    struct dowiazanie *tym=dowiazanie;

    while(tym->lewe!=NULL)
    {
        tym=tym->lewe;
    }
    return tym;
}

int main()
{
    struct dowiazanie *root=NULL;
    int wybor,y;
    do
    {
        system("cls");
        printf("MENU\n");
        printf("1-> Dodanie elementu\n");
        printf("2-> INORDER\n");
        printf("3-> Wyszukanie elementu w drzewie\n");
        printf("4-> Usuwanie elementu z drzewa\n");
        printf("5-> Koniec programu\n");
        printf("Podaj cyfre\n");
        scanf("%d",&wybor);
        switch(wybor)
        {
            case 1:
                printf("Podaj nowy element\n");
                scanf("%d",&y);
                if(wyszukaj(y,root)==NULL)
                {
                    root=dodaj(y,root);
                }
                else
                {
                    printf("Taki element juz jest\n");
                    getchar();
                }
                printf("\n\n");
            system("pause");
            break;
			case 2:
                if(root!=NULL)
                {
                    printf("Elementy podanego drzewa\n");
                    przeglad(root);
                }
                else
                {
                    printf("Drzewo puste\n");
                }
                printf("\n\n");
                system("pause");
			break;
			case 3:
                printf("Podaj jakiego elementu szukasz\n");
                scanf("%d",&y);
                if(wyszukaj(y,root)!=NULL)
                {
                    printf("Podany element znajduje sie w drzewie\n");
                }
                else
                {
                    printf("Nie ma takiego elementu drzewa\n");
                }
                printf("\n\n");
                system("pause");
	        break;
	        case 4:
                printf("Podaj co chcesz usunac\n");
                scanf("%d",&y);
                if(wyszukaj(y,root)!=NULL)
                {
                    root=kasuj(y,root);
                    printf("Usunales %d\n",y);
                }
                else
                {
                    printf("Nie mozna usunac\n");
                }
                printf("\n\n");
                system("pause");
	        break;
	    }
    }
    while(wybor!=5);
    return 0;
}
