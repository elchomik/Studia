#Zadanie 1

men=c(9.88, 9.97, 10.00, 10.02, 10.04, 10.06, 10.07, 10.08, 10.09, 10.09,
  10.11, 10.11, 10.12, 10.13, 10.13, 10.14, 10.16, 10.16, 10.19, 10.20, 10.21,
  10.22, 10.22, 10.22, 10.22, 10.23, 10.24, 10.26, 10.27, 10.28, 10.29, 10.30,
  10.30, 10.31, 10.31, 10.31, 10.34, 10.35, 10.35, 10.38, 10.40, 10.41, 10.48,
  10.53, 10.54, 10.55, 10.59, 10.65, 10.65, 10.69, 10.71, 10.84, 10.90, 10.94)
kob= c(10.83, 10.93, 10.94, 10.96, 10.97, 10.97, 10.99, 11.00, 11.01,
       11.04, 11.06, 11.07, 11.07, 11.07, 11.08, 11.12, 11.13, 11.14, 11.14, 11.18,
       11.19, 11.22, 11.22, 11.27, 11.28, 11.31, 11.32, 11.34, 11.35, 11.36, 11.38,
       11.39, 11.41, 11.41, 11.41, 11.41, 11.42, 11.43, 11.44, 11.46, 11.48, 11.49,
       11.52, 11.56, 11.59, 11.62, 11.63, 11.70, 11.81, 11.82, 11.86, 11.89, 11.90,
       11.92, 11.98, 12.06, 12.35)
length(men)
length(kob)
meanMen=mean(men)
meanKob=mean(kob)
menVar=var(men)
kobVar=var(kob)
menSd=sd(men)
kobSd=sd(kob)

shapiro.test(men) #badanie czy men posiada rozkład normalny
shapiro.test(kob) #badanie czy kob posiada rozkład normalny

dane=rbind(c(length(kob),meanKob,kobVar,kobSd,shapiro.test(kob)$p.value)
           ,c(length(men),meanMen,menVar,menSd,shapiro.test(men)$p.value))
dane
rownames(dane)=c('Kobiety','Mężczyźni')
dane
colnames(dane)=c('n','mean','var','sd','p.value')
dane

group=c(rep(1,length(men)),rep(2,length(kob)))

levene.test(c(men,kob),group)

boxplot(men,kob,col='blue',names = c('Mężczyźni','Kobiety'))

#Zadanie 2
publ=c(4.2, 6.1, 4.9, 8.5, 4.6, 9.1, 7.7, 6.5, 6.2, 10.2, 11.6, 10.4,
       5.0, 10.4, 8.1)
priv=c(13.0, 18.8, 13.2, 14.4, 17.7, 17.7, 17.6, 19.8, 16.8, 16.1)

shapiro.test(publ)
shapiro.test(priv)

var.test(priv,publ)

publSd=sd(publ)
privSd=sd(priv)
meanPubl=mean(publ)
meanPriv=mean(priv)

tsum.test(meanPriv,privSd,length(priv)
          ,meanPubl,publSd,length(publ),mu = 10,alternative = 'greater')

t.test(priv,publ,paired = F,mu=10,alternative = 'greater')

#Zadanie 3

zapylona=c(0.78,0.76,0.43,0.92,0.86,0.59,0.68)
niezapylona=c(0.21,0.12,0.32,0.29,0.30,0.20,0.14)

var(zapylona)
var(niezapylona)
sd(zapylona)
sd(niezapylona)

shapiro.test(zapylona)
shapiro.test(niezapylona)

roznica=niezapylona-zapylona
roznica

t.test(niezapylona,zapylona,alternative = 'greater',paired=TRUE,mu=0)
t.test(roznica,mu=0)
pairwise.t.test(niezapylona,zapylona,alternative = 'greater')
shapiro.test(roznica)
boxplot(list(niezapylona,zapylona),col=5,las=1)


#zadanie 4
cuk1=c(10.1,10.9,11.2,10.7)
cuk2=c(12.1,11.9,12.3)
cuk3=c(12.3,12.2,13.2,13.5,13.1)
cuk4=c(12.4,12.5,12.9,13.1)

waga=c(cuk1,cuk2,cuk3,cuk4)

rodzaj=rep(c("Mleczna","Kokosowa","Czekoladowa","Toffi")
           ,c(length(cuk1),length(cuk2),length(cuk3),length(cuk4)))

ramka=data.frame(waga,rodzaj)

qplot(rodzaj,waga,data=ramka,geom="boxplot",main="Cukierki")

meanMleczna=mean(cuk1)
meanKokos=mean(cuk2)
meanCzekolada=mean(cuk3)
meanToffi=mean(cuk4)

varMleczna=var(cuk1)
varKokos=var(cuk2)
varCzekolada=var(cuk3)
varToffi=var(cuk4)

shapiroMleczna=shapiro.test(cuk1)
shapiroKokos=shapiro.test(cuk2)
shapiroCzekolada=shapiro.test(cuk3)
shapiroToffi=shapiro.test(cuk4)

shapiroToffi

shapiroKokos$p.value

dane=rbind(c(length(cuk1),meanMleczna,varMleczna,shapiroMleczna$p.value),
           c(length(cuk2),meanKokos,varKokos,shapiroKokos$p.value),
           c(length(cuk3),meanCzekolada,varCzekolada,shapiroCzekolada$p.value),
           c(length(cuk4),meanToffi,varToffi,shapiroToffi$p.value))
rownames(dane)=c("Mleczna","Kokosowa","Czekoladowa","Toffi")
dane
colnames(dane)=c("n","mean","var","p.value")

dane

lista=list(cuk1,cuk2,cuk3,cuk4)

bartlett.test(lista)


