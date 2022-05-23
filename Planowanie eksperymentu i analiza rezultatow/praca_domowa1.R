#Zadanie1 
       
#w wektorze wynikiKostki znajduje sie
#ilosc wylosowanych liczb z zkaresu 1 do 10
#zmienna prawdopodobienstwoWyolosowanychLiczb zawiera prawdopodobieństwo wylosowania
#każdej liczby w danym rzucie, kostka 10 ścienna to 1/10 na każdą liczbę
wynikiKostki=c(6,2,6,7,0,3,4,2,8,3)
prawdopodobienstwoWylosowaniaLiczb=
  c(1/10,1/10,1/10,1/10,1/10,1/10,1/10,1/10,1/10,1/10)
chisq.test(wynikiKostki,p=prawdopodobienstwoWylosowaniaLiczb)
barplot(wynikiKostki,las=1,names.arg=c(1:10),
        cex.axis=0.75, cex.names = 0.75)

#Zadanie 2
liczbaGoli=c(0,1,2,3,4)
liczbaMeczy=c(5,8,14,14,9)
lambda=weighted.mean(liczbaGoli,liczbaMeczy)
wynik=liczbaGoli/liczbaMeczy
chisq.test(wynik,rpois(5,lambda))

teoretyczna=dchisq(wynik,8)
empiryczna=dnorm(wynik)
daneBarplot=rbind(empiryczna,teoretyczna)
barplot(daneBarplot,beside=T,names.arg =round(teoretyczna,7),
        main="Zależność teoretyczna od empirycznej",
        col=c(2,5),xlab="Teoretyczna",ylab = "Empiryczna",
        space=c(0.2,1),
        ylim=c(0,0.5)
        )

#Zadanie 3
wektor=c(0.24, 1.2, -0.6, 0.44, 1.7, 0.4, 3.5, -1.6, -0.8, 0.4, 0.5, -0.8, 1.1, 0.5,
         -0.6, 1.6, -0.7, 2.1, -0.2, -0.36, 0.84, 3.8, 1.2, -2.3, -0.4, -2.1, 0.2,
         -0.8, 1.2, 0.12, -0.4, 0.26, -0.1, 0.46, 0.15)
srednia=mean(wektor)
srednia
lambda3=1/srednia
lambda3
pnormsd=sd(wektor)
pnormsd
dys = function(x) {
  return(pnorm(x,mean = srednia, sd = pnormsd))
}
curve(dys,from = -5, to = 5, lty = 2)
lines(ecdf(wektor),las=1,col=5)
ks.test(wektor,dys(wektor))
ks.test(wektor,rnorm(wektor,mean = srednia,sd=pnormsd))

shapiro.test(wektor)
qqnorm(wektor)
qqline(wektor)

#Zadanie 4
#podpunkt a
wektor2=c(2.94, 4.6, 7.14, 7.35, 13.48, 10.22, 3.21, 13.85, 3.54, 6.6, 6.73, 4.96,
          10.27, 6.68, 4.5, 8.11, 7.45, 6.93, 12.4, 14.77)

pexp(wektor2)
ks.test(wektor2,pexp(wektor2))
plot(wektor2,pexp(wektor2),las=1,lwd=3)

#podpunkt b
df=chisq.test(wektor2)
df
yValue=chisq.test(wektor2,pchisq(wektor2,19))
yValue
plot(wektor2,pchisq(wektor2,19),las=3,lwd=1)

ks.test(wektor2,pchisq(wektor2,19))

#podpunkt c
dane=c(2:16)
sredniaC=mean(dane)
sdC=sd(dane)
ks.test(c(2:16),pnorm(dane,mean = sredniaC,sd=sdC))
plot(dane,pnorm(dane,mean=sredniaC,sd=sdC),lwd=3,col=5)


#Zadanie 5
#podpunkt a
pom=read.csv2(file.choose(),header=TRUE,sep=";")
ludnosc=pom$lud
ludnosc1=cyfra(ludnosc,1)
ludnosc1

ludnosc2=cyfra(ludnosc,2)
ludnosc2

daneCyfry=table(ludnosc1,ludnosc2)
daneCyfry

library(TeachingDemos)
chisq.test(daneCyfry)
chisq.detail(daneCyfry)

cyfra=function(x,n){
  y=as.character(abs(x))
  d=substr(y,n,n)
  d2=as.numeric(d)
  return(d2)
}

library(lattieceExtra)

#podpunkt b
wspolczynnikKorelacji=cor(ludnosc1,ludnosc2)
wspolczynnikKorelacji

#Zadanie6
ramka=USAge.df
head(ramka)
wiek=c("0-5","6-11","12-17","18-23","24-29","30-35","36-41",
       "42-47","48-53","54-59","60-65","66-71","72+")


rok1960=ramka[ramka$Year==1960,]
rok1960



przedzialK1=sum(rok1960$Age<=5 & rok1960$Sex=="Female")
przedzialK2=sum(rok1960$Age>5 & rok1960$Age<=11 & rok1960$Sex=="Female")
przedzialK3=sum(rok1960$Age>11 & rok1960$Age<=17 & rok1960$Sex=="Female")
przedzialK4=sum(rok1960$Age>17 & rok1960$Age<=23 & rok1960$Sex=="Female")
przedzialK5=sum(rok1960$Age>23 & rok1960$Age<=29 & rok1960$Sex=="Female")
przedzialK6=sum(rok1960$Age>29 & rok1960$Age<=35 & rok1960$Sex=="Female")
przedzialK7=sum(rok1960$Age>35 & rok1960$Age<=41 & rok1960$Sex=="Female")
przedzialK8=sum(rok1960$Age>41 & rok1960$Age<=47 & rok1960$Sex=="Female")
przedzialK9=sum(rok1960$Age>47 & rok1960$Age<=53 & rok1960$Sex=="Female")
przedzialK10=sum(rok1960$Age>53 & rok1960$Age<=59 & rok1960$Sex=="Female")
przedzialK11=sum(rok1960$Age>59 & rok1960$Age<=65 & rok1960$Sex=="Female")
przedzialK12=sum(rok1960$Age>65 & rok1960$Age<=71 & rok1960$Sex=="Female")
przedzialK13=sum(rok1960$Age>71 & rok1960$Sex=="Female")



przedzialM1=sum(rok1960$Age<=5 & rok1960$Sex=="Male")
przedzialM2=sum(rok1960$Age>5 & rok1960$Age<=11 & rok1960$Sex=="Male")
przedzialM3=sum(rok1960$Age>11 & rok1960$Age<=17 & rok1960$Sex=="Male")
przedzialM4=sum(rok1960$Age>17 & rok1960$Age<=23 & rok1960$Sex=="Male")
przedzialM5=sum(rok1960$Age>23 & rok1960$Age<=29 & rok1960$Sex=="Male")
przedzialM6=sum(rok1960$Age>29 & rok1960$Age<=35 & rok1960$Sex=="Male")
przedzialM7=sum(rok1960$Age>35 & rok1960$Age<=41 & rok1960$Sex=="Male")
przedzialM8=sum(rok1960$Age>41 & rok1960$Age<=47 & rok1960$Sex=="Male")
przedzialM9=sum(rok1960$Age>47 & rok1960$Age<=53 & rok1960$Sex=="Male")
przedzialM10=sum(rok1960$Age>53 & rok1960$Age<=59 & rok1960$Sex=="Male")
przedzialM11=sum(rok1960$Age>59 & rok1960$Age<=65 & rok1960$Sex=="Male")
przedzialM12=sum(rok1960$Age>65 & rok1960$Age<=71 & rok1960$Sex=="Male")
przedzialM13=sum(rok1960$Age>71 & rok1960$Sex=="Male")



wiekPrzedzialK=c(przedzialK1,przedzialK2,przedzialK3,przedzialK4,przedzialK5,
                 przedzialK6,przedzialK7,przedzialK8,przedzialK9,przedzialK10,
                 przedzialK11,przedzialK12,przedzialK13)

wiekPrzedzialM=c(przedzialM1,przedzialM2,przedzialM3,przedzialM4,przedzialM5,
                 przedzialM6,przedzialM7,przedzialM8,przedzialM9,przedzialM10,
                 przedzialM11,przedzialM12,przedzialM13)


pyramid.plot(
  wiekPrzedzialK, 
  wiekPrzedzialM, 
  labels = wiek, 
  space = 0.5,
  main='Wykres demograficzny miast w 1960 roku',
  )

#Zadanie 7


U=sample(c(1:365),21,replace = T)
U


#Zadanie8

probkaLosowa=c(15.5, 34.6, 8.1, 39.6, 43.1, 37.4, 52.8, 27.5, 7.5, 15.3, 85.6, 14.1,
81.3, 6.5, 90.8, 23.8, 42.9, 66.7,41.5,82.8, 66.1, 18.3, 24.1, 81.9,
36.9, 74.9, 50.2, 91.4, 57.7, 8.7, 20.5, 4.2, 43.3, 59.4, 5.7, 27.7, 4.9,
17.3, 53.5, 32.6, 65.8, 74.1, 14.7, 58.4, 36.7, 94.6, 72.9, 92.1, 24.8,
70.8, 84.1, 23.7, 10.3, 32.3, 20.3, 46.5, 64.8, 36.2, 31.6, 95.9, 62.4,
2.4, 19.4, 60.6, 75.7, 28.5, 73.1, 79.2, 91.2, 29.4, 18.4, 29.6, 67.2,
41.9, 28.9, 23.8, 51.2, 67.4, 43.2, 12.3, 26.4, 17.1, 2.5, 84.9, 27.1,
40.2, 34.6, 23.4, 31.7, 36.8, 25.3, 34.3, 13.7, 57.4, 36.9, 15.7, 82.7,
23.2, 96.3, 17.1)

granice = c(0, 5, 10, 15, 20, 30, 40, 50, 61, 72, 83, 100) 

#podpunkt a

hist(probkaLosowa,breaks=granice)

#podpunkt b
mean(probkaLosowa)
var(probkaLosowa)

#podpunkt c
 
posortowanaProbkaLosowa=sort(probkaLosowa)
posortowanaProbkaLosowa

podgrupy=function(dane){
  podgrup1=NULL
  podgrup2=NULL
  podgrup3=NULL
  podgrup4=NULL
  podgrup5=NULL
  podgrup6=NULL
  podgrup7=NULL
  podgrup8=NULL
  podgrup9=NULL
  podgrup10=NULL
  podgrup11=NULL
  for(i in c(1:length(dane))){
    if(dane[i]<5){
      podgrup1=append(podgrup1,values = dane[i],after = length(podgrup1))
    }
    else if(dane[i]>5 & dane[i]<10){
      podgrup2=append(podgrup2,values = dane[i],after = length(podgrup2))
    }
    else if(dane[i]>10 & dane[i]<15){
      podgrup3=append(podgrup3,values = dane[i],after = length(podgrup3))
    }
    else if(dane[i]>15 & dane[i]<20){
      podgrup4=append(podgrup4,values = dane[i],after = length(podgrup4))
    }
    else if(dane[i]>20 & dane[i]<30){
      podgrup5=append(podgrup5,values = dane[i],after = length(podgrup5))
    }
    else if(dane[i]>30 & dane[i]<40){
      podgrup6=append(podgrup6,values = dane[i],after = length(podgrup6))
    }
    else if(dane[i]>40 & dane[i]<50){
      podgrup7=append(podgrup7,values = dane[i],after = length(podgrup7))
    }
    else if(dane[i]>50 & dane[i]<61){
      podgrup8=append(podgrup8,values = dane[i],after = length(podgrup8))
    }
    else if(dane[i]>61 & dane[i]<72){
      podgrup9=append(podgrup9,values = dane[i],after = length(podgrup9))
    }
    else if(dane[i]>72 & dane[i]<83){
      podgrup10=append(podgrup10,values = dane[i],after = length(podgrup10))
    }
    else{
      podgrup11=append(podgrup11,values = dane[i],after = length(podgrup11))
    }
  }
  
  print(paste0("Średnia dla pierwszej podgrupy ",mean(podgrup1)))
  print(paste0("Wariancja dla pierwszej podgrupy ",var(podgrup1)))
  print("-----------")
  
  print(paste0("Średnia dla 2 podgrupy ",mean(podgrup2)))
  print(paste0("Wariancja dla 2 podgrupy ",var(podgrup2)))
  print("-----------")
  
  print(paste0("Średnia dla 3 podgrupy ",mean(podgrup3)))
  print(paste0("Wariancja dla 3 podgrupy ",var(podgrup3)))
  print("-----------")
  
  print(paste0("Średnia dla 4 podgrupy ",mean(podgrup4)))
  print(paste0("Wariancja dla 4 podgrupy ",var(podgrup4)))
  print("-----------")
  
  print(paste0("Średnia dla 5 podgrupy ",mean(podgrup5)))
  print(paste0("Wariancja dla 5 podgrupy ",var(podgrup5)))
  print("-----------")
  
  print(paste0("Średnia dla 6 podgrupy ",mean(podgrup6)))
  print(paste0("Wariancja dla 6 podgrupy ",var(podgrup6)))
  print("-----------")
  
  print(paste0("Średnia dla 7 podgrupy ",mean(podgrup7)))
  print(paste0("Wariancja dla 7 podgrupy ",var(podgrup7)))
  print("-----------")
  
  print(paste0("Średnia dla 8 podgrupy ",mean(podgrup8)))
  print(paste0("Wariancja dla 8 podgrupy ",var(podgrup8)))
  print("-----------")
  
  print(paste0("Średnia dla 9 podgrupy ",mean(podgrup9)))
  print(paste0("Wariancja dla 9 podgrupy ",var(podgrup9)))
  print("-----------")
  
  print(paste0("Średnia dla 10 podgrupy ",mean(podgrup10)))
  print(paste0("Wariancja dla 10 podgrupy ",var(podgrup10)))
  print("-----------")
  
  print(paste0("Średnia dla 11 podgrupy ",mean(podgrup11)))
  print(paste0("Wariancja dla 11 podgrupy ",var(podgrup11)))
 
  
}

podgrupy(probkaLosowa)

