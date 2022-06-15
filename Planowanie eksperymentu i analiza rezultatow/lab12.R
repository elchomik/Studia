#mlecznoœæ ków, zad6
r1=c(35,40,32,40,41,39)
r2=c(35,48,42,48,45)
r3=c(32,39,42,32,35,40)

#badanie normalnoœci
shapiro.test(r1)
qqnorm(r1)
qqline(r1)

shapiro.test(r2)
qqnorm(r2)
qqline(r2)

shapiro.test(r3)
qqnorm(r3)
qqline(r3)

#badanie normalnoœci wariancji
bartlett.test(list(r1,r2,r3))

var(r1)
var(r2)
var(r3)
boxplot(list(r1,r2,r3),las=1,col=5)

#tworzymy ramkê danych
Laktacja=c(r1,r2,r3)

#tworzymy zmienna grupuj¹c¹
Rasa=rep(c("Rasa1","Rasa2","Rasa3"),
         c(length(r1),length(r2),length(r3)))

Rasa
Dane=data.frame(Laktacja,Rasa)
head(Dane)

#Analiza wariancji
Analiza=aov(Laktacja~Rasa,data=Dane)
summary(Analiza)
plot.design(data.frame(Laktacja,factor(Rasa)))
pairwise.t.test(Dane$Laktacja,Dane$Rasa)

#róznice miedzywynikami rasy
TukeyHSD(Analiza)
plot(TukeyHSD(Analiza),las=1)

t.test(r1,r2)
mean(r1)
mean(r2)

granova.1w(Dane$Laktacja,Dane$Rasa)

#Zadanie 2, irysy
#analizawariancji

head(iris)
Setosa=subset(iris,Species=="setosa")
head(Setosa)

Versicolor=subset(iris,Species=="versicolor")
Virginica=subset(iris,Species=="virginica")

shapiro.test(Setosa$Sepal.Length)
qqnorm(Setosa$Sepal.Length)
qqline(Setosa$Sepal.Length)

shapiro.test(Versicolor$Sepal.Length)
shapiro.test(Virginica$Sepal.Length)

#badanie równosci wariancji
bartlett.test(Sepal.Length~Species,data=iris)

boxplot(Sepal.Length~Species,data=iris,col=5,las=1)

summaryBy(Sepal.Length~Species,data=iris,FUN = c(mean,var))
Analiza2=aov(Sepal.Length~Species,data=iris)
summary(Analiza2)

##Zadanie2a,analiz awariancji
head(iris)
tail(iris)

bartlett.test(Petal.Length~Species,data = iris)
bartlett.test(Petal.Width~Species,data=iris)

Analiza3=aov(Sepal.Width~Species,data=iris)

summary(Analiza3)
boxplot(Sepal.Width~Species,data=iris,col=5,las=1)

#Zadanie3 kurczaki, kaczki
chickwts

summary(chickwts)
CA=subset(chickwts,feed=="casein")
shapiro.test(CA$weight)
qqnorm(CA$weight)
qqline(CA$weight)

HO=subset(chickwts,feed="horsebean")
LN=subset(chickwts,feed="linseed")
SO=subset(chickwts,feed="soybean")
MM=subset(chickwts,feed="meatmeal")
SF=subset(chickwts,feed="sunflower")

bartlett.test(weight~feed,data = chickwts)

boxplot(weight~feed,data = chickwts,col=5,las=1)

summaryBy(weight~feed,data = chickwts,FUN=c(mean,var))

analiza1=aov(weight~feed,data = chickwts)

summary(analiza1)
plot.design(chickwts)

pairwise.t.test(chickwts$weight,chickwts$feed)

par(mar=c(3,10,4,1))
TukeyHSD(analiza1)
plot(TukeyHSD(analiza1),las=1)


#Zadanie 4 wykres ko³owy
nazwy=c("Partia A","Partia B","Partia C","Partia D","inne")
sond=c(38,24,16,16,6)
pie(sond,labels = nazwy,radius = 1,main="sondaz",col=rainbow(length(sond)),cex=1,clockwise = T)

sondproc=percent(sond,accuracy = 1,scale=1,suffix="%")
pie(sond,labels=sondproc,radius=1,main="sondaz",col=rainbow(length(sond)),cex=0.9,init.angle = 30)
legend("topright",nazwy,cex=0.6,fill=rainbow(length(sond)))


#zadanie 5 pie 3d

woj=c("lubelskie","lubuskie","mazowieckie","dolnoslaskie","slaskie","kujawsko-pomorskie",
      "zachodniopomorskie","pomorskie","swietokrzyskie","wielkopolskie",
      "warminskowmazurskie","lodzkie","malopolskie","opolskie","podlaskie","podkarpackie")

pow=c(19947,17972,25122,13988,18219,15183,35558,9412,17846,20187,18310,
      12333,11711,24173,29826,22892)

pow2=round(100*pow/sum(pow),1)
pow3=percent(pow2,accuracy = 0.1,scale=1,suffix="%",trim=F,decimal.mark = ".")

lud=c(2.9,2.1,2.1,1.0,2.5,3.4,5.4,1.0,2.1,1.2,2.3,4.5,1.2,1.4,3.5,1.7)
lud2=round(100*lud/sum(lud),1)
lud3=percent(lud2,accuracy = 0.1,scale=1,suffix="%")
lmiast=c(91,52,48,43,46,62,89,36,51,40,42,71,44,50,113,66)
PolskaGUROM=data.frame(woj,pow,lud,lmiast)
PolskaGUROM
PolskaGUROM$"pow %"=round(100*pow/sum(pow),1)
PolskaGUROM$"lud %"=round(100*lud/sum(lud),1)
PolskaGUROM$"lmiast %"=round(100*lmiast/sum(lmiast),1)
PolskaGUROM

margins=c(4,0,4,10)
pie3D(lud,radius=0.95,theta=1.1,main="RP, ludnosc",cex.main=1.1,
      col=rainbow(length(lud)),labels=lud3,labelcex = 0.71,
      explode=0.07,mar=margins)

legend(1.7,1.6,woj,cex=0.6,title="wojewodztwa",fill=rainbow(length(pow)),xpd=T)


#inna wersja
pie3D(lmiast,radius=0.95,theta=0.85,main="RP,liczba miast",cex.main=1,col=topo.colors(length(lud)),
      labels = lmiast,labelcex = 0.8,explode=0,mar=margins)
