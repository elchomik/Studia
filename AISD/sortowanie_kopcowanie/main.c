#include <stdio.h>
#include <stdlib.h>

void czytaj(int k,int *tab);
void wydruk(int k,int *tab);
void kopiec(int i,int k,int *tab);
void kopcowanko(int k,int *tab);
int main()
{
    int k;
    int *tab;
    tab=(int*)malloc(sizeof(int));
	printf("Podaj ilosc elementow\n");
	scanf("%d",&k);
    czytaj(k,tab);
    printf("Elementy przed sortowaniem\n");
    wydruk(k,tab);
    kopcowanko(k,tab);
    printf("Elementy po sortowaniu\n");
    wydruk(k,tab);

    return 0;
}
void czytaj(int k,int *tab)
{
	int i, j;
	for(i=0;i<k;i++)
    {
        printf("Podaj element %d ", i);
        scanf("%d", &tab[i]);
        for(j=0;j<i;j++)
        {
            if(tab[j]==tab[i])
            {
                printf("Mamy juz taki element\n");
                i--;
            }
        }
    }
}
void kopiec(int i,int k,int *tab)
{
    int max=i;
    int l_syn=2*i+1;
    int p_syn=2*i+2;
    int pomocnicza;
    if(tab[l_syn]>tab[max]&&l_syn<k)
    {
        max=l_syn;
    }
    if(tab[p_syn]>tab[max]&&p_syn<k)
    {
        max=p_syn;
    }
    if(max!=i)
    {
        pomocnicza=tab[i];
        tab[i]=tab[max];
        tab[max]=pomocnicza;
        kopiec(max,k,tab);
    }
}

void kopcowanko(int k,int *tab)
{
    int i, pomocnicza;
    for(i=k/2-1;i>=0;i--)
    {
        kopiec(i,k,tab);
    }
    for(i=k-1;i>=0;i--)
    {
        pomocnicza=tab[0];
        tab[0]=tab[i];
        tab[i]=pomocnicza;
        kopiec(0,i,tab);
    }
}
void wydruk(int k, int tab[])
{
    for(int i=0;i<k;i++)
    {
        printf(" %d\n",tab[i]);
    }
}
