#### PEIAR 2021/2022, dzienne 
### Cwiczenia 9, 10 maja 2022


##### Zadanie 1, Zadanie 1
### dwie wariancje,  F-test, symulacja
### n-liczba probek, m-wielkosc jednej probki

Sym1<- function(n,m)
{
  p=numeric()
  
  for (i in c(1:n))
  {
    x1=rnorm(m,mean=0,sd=5) # normalny
    x2=rnorm(m,mean=10,sd=5) # normalny
    
    h=var.test(x1,x2)
    p[i]=h$p.value
  }
  return(p)
}

dane1=Sym1(1000,20)
dane1

length(which(dane1>0.05))

hist(dane1,las=1,freq=F)
abline(h=1,col=2)
ks.test(dane1,"punif",0,1)

plot(qunif(ppoints(dane1),0,1),sort(dane1),las=1,asp=1)
abline(0,1)



##### Zadanie 2, Zadanie 2
### dwie wariancje, dwie wariancje
### F-test, levene.test

library(lawstat)

Sym2<- function(n,m)
{
  p1=numeric(); p2=numeric()
  
  for (i in c(1:n))
  {
    x1=rexp(m,0.1) # wyk?adniczy
    
    x2=rexp(m,0.1) # wyk?adniczy
    
    h1=var.test(x1,x2)
    p1[i]=h1$p.value
    
    gr=c(rep(1,length(x1)),rep(2,length(x2)))
    
    h2=levene.test(c(x1,x2),gr)
    p2[i]=h2$p.value
  }
  dane=list(p1,p2)
  return(dane)
}
dane2=Sym2(1000,20)
dane2

length(which(dane2[[1]]>0.05))

length(which(dane2[[2]]>0.05))

dev.off()
par(mfrow=c(1,2))

hist(dane2[[1]],las=1,cex.axis=0.8,freq = F)
hist(dane2[[2]],las=1,cex.axis=0.8,freq=F)




library(lawstat)
ks.test(dane2[[2]],"punif",0,1)

x1=rexp(20,0.1)
x2=rexp(25,0.1)
var(x1);var(x2)

group=c(rep(1,length(x1)),rep(2,length(x2)))
group

levene.test(c(x1,x2),group)

##### Zadanie 3, Zadanie 3
### dwie ?rednie, pr?by niezale?ne
### kierowcy, kierowcy
dev.off()

R=read.csv2(file.choose(),header= TRUE,sep = ";")

head(R)
tail(R)
boxplot(R,col=5,horizontal = F)

shapiro.test(R$Kierowca1)
qqnorm(R$Kierowca1)
qqline(R$Kierowca1)

shapiro.test(R$Kierowca2)

mean(R$Kierowca1);mean(R$Kierowca2)
summary(R$Kierowca1)
summary(R$Kierowca2)

sd(R$Kierowca1); sd(R$Kierowca2) 
var.test(R$Kierowca1,R$Kierowca2)

t.test(R$Kierowca1,R$Kierowca2,
       var.equal = F)



boxplot(R,col=5,las=1,horizontal = T)

qqplot(R$Kierowca1,R$Kierowca2,las=1)

abline(0,1)

var.test(R$Kierowca1,R$Kierowca2,alternative = "less")


t.test(R$Kierowca1,R$Kierowca2,alternative = "less",
       var.equal = F)



##### Zadanie 4, Zadanie 4
### dwie ?rednie, pr?by niezale?ne
### Jajka, Kiwi, Man

R2=read.csv2(file.choose(),header= TRUE,sep = ";")

boxplot(R2,col=5,las=1)
head(R2)
tail(R2)

boxplot(R2,col=5,las=1)
shapiro.test(R2$Jajka)
shapiro.test(R2$Kiwi)
shapiro.test(R2$Man)

t.test(R2$Jajka,R2$Kiwi)
summary(R2$Jajka)
summary(R2$Kiwi)
qqplot(R2$Jajka,R2$Kiwi)
abline(0,1)

t.test(R2$Kiwi,R2$Man)

summary(R2$Kiwi)
summary(R2$Man)
sd(R2$Jajka);sd(R2$Kiwi)
var.test(R2$Jajka,R2$Kiwi)

qqplot(R2$Kiwi,R2$Man)
abline(0,1)

t.test(R2$Jajka,R2$Man)
summary(R2$Jajka)
summary(R2$Man)
qqplot(R2$Jajka,R2$Man)
abline(0,1)
t.test(R2$Jajka,R2$Man,alternative="less")



mean(R2$Jajka);mean(R2$Kiwi);mean(R2$Man)
sd(R2$Jajka); sd(R2$Kiwi); sd(R2$Man)
var.test(R2$Jajka,R2$Kiwi)
var.test(R2$Jajka,R2$Man)
var.test(R2$Kiwi,R2$Man)
t.test(R2$Jajka,R2$Kiwi)
t.test(R2$Jajka,R2$Man)
t.test(R2$Kiwi,R2$Man)



##### Zadanie 5, Zadanie 5
### dwie ?rednie, pr?by zale?ne
### zadanie 10, ?w. 7,8, dzia?anie leku

przed=c(179, 131, 188, 126, 162, 192, 174, 191, 
        161, 149, 155, 186, 213, 158, 192, 186, 
        169, 169, 185, 141)

length(przed)

po=c(145, 166,179, 189, 155, 163, 168, 141, 
     143, 169, 153, 148,167, 
     185, 173, 180, 173, 162, 178, 159)

boxplot(list(przed,po),col=5)
summary(przed)
summary(po)
var(przed);var(po)
sd(przed); sd(po)

roznica=przed-po
roznica
shapiro.test(przed)
shapiro.test(po)

shapiro.test(roznica)
qqnorm(roznica,las=1)
qqline(roznica)

t.test(przed,po,paired=T,alternative = "greater")

t.test(roznica,mu=0)


shapiro.test(przed)
shapiro.test(po)

boxplot(list(przed,po),las=1,col=5)
mean(przed);mean(po)
sd(przed); sd(po)
var.test(przed,po)

ks.test(przed,po)
qqplot(przed,po)
abline(0,1)

##### Zadanie 6, Zadanie 6
### test serii, test serii
## co si? dzieje?


z1=sample(c(0,1),20,replace=T,prob=c(0.9,0.1))
z1
sum(z1)
z2=rep(c(0,1),10)
z2
library(randtests)

runs.test(z1,threshold=0.5,plot=T)


h$runs

Serie<- function(n,m)
{
  r=numeric()
  for (i in c(1:n))
  {
    proba=sample(c(0,1),m,replace=T,prob=c(0.9,0.1))
    h=runs.test(proba,threshold=0.5)
    r[i]=h$runs
  }
  return(r)
}

dane6=Serie(1000,20)
dane6
dane6b=table(dane6)
dane6b

barplot(dane6b,las=1,col=2)

##### Zadanie 7, Zadanie 7
### pojemno?? p?uc

Poj=c(3150,3250,3350,3450,3550,3650,3750,3850,
      3950,4050,4150,4250,4350,4450)
Poj

length(Poj)

M=c(2,8,12,15,20,24,21,17,13,10,5,3,0,0)

W=c(0,0,5,10,14,20,26,34,27,22,18,12,8,4)


length(M)
length(W)

Miasto=rep(Poj,M)

Miasto
length(Miasto)
Wies=rep(Poj,W)

Wies
length(Wies)

ks.test(Miasto,Wies)

plot(ecdf(Miasto))
lines(ecdf(Wies),col=2)

qqplot(Miasto,Wies,las=1)
abline(0,1)

shapiro.test(Miasto)
shapiro.test(Wies)

mean(Miasto);mean(Wies)
summary(Miasto)
summary(Wies)

sd(Miasto);sd(Wies)

t.test(Miasto,Wies)

boxplot(list(Miasto,Wies),las=1,col=5,
        horizontal=F)


############## Zadanie 8 (Zad 1 ?wicz5/6)
##### Ruletka, Ruletka

wyniki=c(23,6,21,24,18,11,0,33,35,16,7,28,21,27,18,6,26,31,35, 13,27,
         0,25,4,19,17,27,4,5,33,7,26,25,16,21,0,9,6,6,30, 7,1,23,19,1,
         13,8,2,2,22,19,23,11,10,17,2,26,16,15,8,12,31,13,19, 15,10,19,
         23,24,27,15,30,17,22,17,33,26,34,8,6,4,27,19,21,26,4,
         9,7,15,30,12,9,5,23,22,18,1,17,36,1)

w2=table(wyniki)
w2
barplot(w2/sum(w2),col=2,las=1)

abline(h=1/37)

kat2=c("0-6","7-13","14-20","21-27","28-36")

k1=length(which(wyniki<=6))
k1
k2=length(which(wyniki>=7 & wyniki<=13))
k3=length(which(wyniki>=14 & wyniki<=20))
k4=length(which(wyniki>=21 & wyniki<=27))
k5=length(which(wyniki>=28))

k=c(k1,k2,k3,k4,k5)

names(k)=kat2
sum(k)


k
pr=c(7/37,7/37,7/37,7/37,9/37)
sum(pr)
chisq.test(k,p=pr)###############09maja22
