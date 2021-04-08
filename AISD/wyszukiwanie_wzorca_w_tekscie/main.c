#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>
#define max(x,y) ((x>y) ? x : y)
void Naiwny(char wzorzec[],char text[]);
void KMP(char wzorzec[],char text[]);
void KarpRabin(char wzorzec[],char text[]);
int potega(int a,int b,int m);
int main()
{
    char wzorzec[200],text[200];
    printf("Podaj wzorzec\n");
    gets(wzorzec);
    printf("Podaj tekst\n");
    gets(text);
    printf(" Algorytm Naiwny\n");
    Naiwny(wzorzec,text);
    printf(" Algorytm KMP\n");
    KMP(wzorzec,text);
    printf("Algorytm KR\n");
    KarpRabin(wzorzec,text);
  return 0;
}
void Naiwny(char wzorzec[], char text[]){
int i=0,j,ilosc_wystapien=0;
int m=strlen(wzorzec);
int n=strlen(text);
while(i<=n-m){
    j=0;
    while((j<m) && (wzorzec[j]==text[i+j])) j++;
    if(j==m){
    printf(" Indeksy na ktorych wystepuje wzorzec ");
    printf("%d\n",i+1);
    ilosc_wystapien++;
    }
    i++;

}
if(ilosc_wystapien==0){
        printf(" W podanym tekscie nie znajduje sie wzorzec\n");
    }

}
void KMP(char wzorzec[],char text[]){
    int t,i,j,p[100],ilosc_wystapien=0;
    int n=strlen(text);
    int m=strlen(wzorzec);
    p[0]=0;
    p[1]=0;
    t=0;
    for(i=2;i<=m;i++){
        while((t>0)&&(wzorzec[t]!=wzorzec[i-1]))
              t=p[t];
              if(wzorzec[t]==wzorzec[i-1])
                t++;
              p[i]=t;
    }
    i=0;
    j=0;
    while(i<=n-m+1){
        while((wzorzec[j]==text[i+j]) && (j<m))
            j++;
        if(j==m){
            printf(" Indeksy poczatku wzorca w tekscie ");
            printf("%d\n",i+1);
            ilosc_wystapien++;
        }

        i=i+max(1,j-p[j]);
         j=p[j];
    }
if(ilosc_wystapien==0)
    printf(" W podanym tekscie wzorzec nie wystepuje \n");


}
int potega(int a,int b,int m){
int i,wynik=1;
long int x=a%m;
for(i=1;i<=b;i++){
   x=x%m;
    if((b&i)!=0){
        wynik=wynik*x;
        wynik=wynik%m;
    }
    x=x*x;
}
return wynik%m;
}

void KarpRabin(char wzorzec[],char text[]){
int m,n,i,j,h1,h2,rm;
const  int r=256,q=9551;
m=strlen(wzorzec);
n=strlen(text);
h1=0,h2=0;
for(i=0;i<m;i++){
    h2=(h2*r)+text[i];
    h2%=q;
}
for(i=0;i<m;i++){
    h1=(h1*r)+wzorzec[i];
    h1%=q;
}
rm=potega(q,m-1,r);
i=0;
while(i<n-m){
    j=0;
    if(h1==h2) while((j<m)&&(wzorzec[j]==text[i+1])) j++;
    if(j==m) { printf(" Indeksy na ktorych wystepuj e poczatek wzorca %d\n",i+1);
    }
    h2=((h2-text[i]*rm)*r+text[i+m]);
    h2%=q;
    if(h2<0) h2+=q;
    i++;
}
j=0;
if (h1==h2){
    while ((j<m)&&(wzorzec[j]==text[i+j])) j++;
}
if (j==m){
  printf(" Indeksy  na ktorych wystepuje poczatek wzorca %d\n",i+1);
}
}
