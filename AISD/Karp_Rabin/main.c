#include <stdio.h>
#include <stdlib.h>
int *algorytm_KR(char tekst[],char wzorzec[],int *ilosc);
int potega(int a,int b,int m);
int wyswietl(int tab[], char tekst[], char wzorzec[], int ilosc);
int main()
{
    int i, wybor, *tab, ilosc;
    char tekst[50]={}, wzorzec[50]={};
    printf("Podaj tekst: \n");
    gets(tekst);
    printf("Podaj wzorzec:\n ");
    gets(wzorzec);
    ilosc=0;
    tab = algorytm_KR(tekst, wzorzec, &ilosc);
    wyswietl(tab, tekst, wzorzec, ilosc);

    return 0;
}
int *algorytm_KR(char tekst[], char wzorzec[], int *ilosc)
{
    const r=256, q=9551;
    int m, n, i, j, h1, h2, rm, *tab;
    tab=(int*)malloc(0*sizeof(int));
    n=strlen(tekst);
    m=strlen(wzorzec);
    h2=0;
    h1=0;
    for(i=0;i<m;i++)
    {
        h2=((h2*r)+tekst[i]);
        h2%=q;
    }
    for(i=0;i<m;i++)
    {
        h1=((h1*r)+wzorzec[i]);
        h1%=q;
    }
    rm=potega(r, m-1, q);
    i=0;
    while(i<n-m)
    {
        j=0;
        if(h1==h2)
        {
            while((j<m)&&(wzorzec[j]==tekst[i+j]))
            {
                j++;
            }
        }
        if(j==m)
        {
            tab=(int*)realloc(tab,(*ilosc+1)*sizeof(int));
            tab[*ilosc]=i+1;
            *ilosc+=1;
        }
        h2=((h2-tekst[i]*rm)*r+tekst[i+m]);
        h2%=q;
        if(h2<0)
        {
            h2+=q;
        }
        i++;
    }
    j=0;
    if(h1==h2)
    {
        while ((j<m)&&(wzorzec[j]==tekst[i+j]))
        {
            j++;
        }
    }
    if(j==m)
    {
        tab=(int*)realloc(tab,(*ilosc+1)*sizeof(int));
        tab[*ilosc]=i+1;
        *ilosc+=1;
    }
    return tab;
}
int potega(int a, int b, int m)
{
    int i, wynik=1, x=a%m;

    for (i=1;i<=b;i++)
    {
        x%=m;

        if((b&i)!=0)
        {
            wynik*=x;
            wynik%=m;
        }

        x*=x;
    }

    return wynik%m;
}
int wyswietl(int tab[], char tekst[], char wzorzec[], int ilosc)
{
    int i;

    if(ilosc>0 && strlen(tekst)>0 && strlen(wzorzec)>0)
    {
        printf("\nWystapienia wzorca w tekscie na pozycjach : %d ", tab[0]);

        for(i=1;i<ilosc;i++)
        {
            printf(", %d", tab[i]);
        }
    }
    else
    {
        printf("\nBrak wystapien wzorca w tekscie.");
    }

    fflush(stdin);
    getchar();
}
