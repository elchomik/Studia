#include <stdio.h>
#include <stdlib.h>



//wczytanie
int wczytanie(int n, int tab[])
{
	int i, j;

	for(i=0;i<n;i++)
    {
        printf("Podaj wartosc elementu tablicy dla indeksu %d: ", i);
        scanf("%d", &tab[i]);

        for(j=0;j<i;j++)
        {
            if(tab[j]==tab[i])
            {
                printf("Podano juz taki element. Podaj inny.\n");
                i--;
            }
        }
    }
}

//kopiec
int kopiec(int i, int n, int tab[])
{
    int max=i;
    int lewy=2*i+1;
    int prawy=2*i+2;
    int pom;

    if(tab[lewy]>tab[max]&&lewy<n)
    {
        max=lewy;
    }

    if(tab[prawy]>tab[max]&&prawy<n)
    {
        max=prawy;
    }

    if(max!=i)
    {
        pom=tab[i];
        tab[i]=tab[max];
        tab[max]=pom;

        kopiec(max, n, tab);
    }
}

//kopiec sort
int kopiec_sort(int n, int tab[])
{
    int i, pom;

    for(i=n/2-1;i>=0;i--)
    {
        kopiec(i, n, tab);
    }

    for(i=n-1;i>=0;i--)
    {
        pom=tab[0];
        tab[0]=tab[i];
        tab[i]=pom;

        kopiec(0, i, tab);
    }
}

//wydruk
int wydruk(int n, int tab[])
{
    int i;

    for(i=0;i<n;i++)
    {
        printf(" %d", tab[i]);
    }
}



//fflush(stdin);getchar();
int main()
{
    int n;

	printf("Podaj ilosc elementow do wprowadzenia: ");
	scanf("%d", &n);

	if(n>0)
    {
    	int tab[n];

		wczytanie(n, tab);

		printf("\nElementy przed sortowaniem:");
		wydruk(n, tab);

        kopiec_sort(n, tab);
		printf("\nElementy po sortowaniu:");
		wydruk(n, tab);
    }

    return 0;
}
