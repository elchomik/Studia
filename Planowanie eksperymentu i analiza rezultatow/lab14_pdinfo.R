#praca domowa
#zadanie 1
#sprawdamy rozk³ad normalny badania normalnoœci, jesli jest rozk³ad normalny to zaczynamy var.test
#jeœli nie ma to robimy test Lavene, Bartleta,Flignera
#wykresy kwantylowe jeœli bêdzie normalnoœæ

#zadanie 2
#hipoteza dotyczacej œredniej, roznica miêdzy œrednimi rowna jest wtedy 0 domyœlnie ustawione we wszystkich testach
#na pocz¹tku u1-u2=10, mu=10 ma byæ ustawione w teœcie, zbadaæ czy maj¹ rozk³ad normalny zawsze na poczatku
#stosujemy na pocz¹tku jeœli mamy równoœc to var test potem dopiero test o rownoœci œrednich
#zadania z 10 maja

#zadanie 3
#dwie próby zale¿ne, zbadaæ hipotezê o rownoœci œrednich, przed podaniem leku po podaniu leku zadanie na moodle
#pairwaise.t.test rownoœæ srednich

#zadanie 4
#zbadaæ rozk³ad normalny, równoœæ wariancji, zadanie z krowami 
#zadanie o cukierkach na wyk³adzie



#laboratorium Cwiczenia 11/12
#przedzia³y ufnoœci


#zadanie 0

plotCI(x=c(1,2,3),y=c(1,1.6,1.2),li=c(0.5,1,0.8),
       ui=c(2,2.5,2.3),xlab="",ylab="",
       sfrac=0.007,cex=0.8)

#Zadanie 1
poz1=c(81,78,75,84);poz2=c(82,86,75,71);
poz3=c(74,68,78,82);poz4=c(83,68,79,81);
poz5=c(86,70,72,76);poz6=c(62,70,70,76);
poz7=c(68,66,72,76);poz8=c(74,68,78,82);
poz9=c(68,66,58,71);poz10=c(72,60,65,68);
poz11=c(70,64,66,80);poz12=c(63,74,76,70)

lista1=list(poz1,poz2,poz3,poz4,poz5,poz6,poz7,poz8,poz9,poz10,poz11,poz12)
boxplot(lista1,las=1,col=5)
shapiro.test(poz1)
shapiro.test(poz2)
shapiro.test(poz3)
shapiro.test(poz4)
shapiro.test(poz5)
shapiro.test(poz6)
shapiro.test(poz7)
shapiro.test(poz8)
shapiro.test(poz9)
shapiro.test(poz10)
shapiro.test(poz11)
shapiro.test(poz12)

bartlett.test(lista1)

grupaA=rep(c("A1","A2","A3","A4"),c(12,12,12,12))
grupaB=rep(rep(c("B1","B2","B3"),c(4,4,4)),4)

Poziom=c(poz1,poz2,poz3,poz4,poz5,poz6,poz7,poz8,poz9,poz10,poz11,poz12)
Ramka1=data.frame(Poziom,grupaA,grupaB)

head(Ramka1)
Ramka1


boxplot(Poziom~grupaA,data=Ramka1,las=1,col=5)
boxplot(Poziom~grupaB,data=Ramka1,las=1,col=5)

#analiza wariancji dwuczynnikowej
analiza=aov(Poziom~grupaA*grupaB,data=Ramka1)
summary(analiza)

#œrednie s¹ rozne ze wzglêdu na grupêA
#œrednie s¹ rowne ze wzglêdu na grupêB
#Brak interakcji dzia³ania addytywne
plot.design(Ramka1,las=1)
lekaa=as.factor(Ramka1$grupaA)
lekB=as.factor(Ramka1$grupaB)
ramka=data.frame(Poziom,lekaa,lekB)

str(ramka)
plot.design(ramka,las=1)

interaction.plot(Ramka1$grupaA,Ramka1$grupaB,Ramka1$Poziom,las=1,main="Wykresy interakcj")

interaction.plot(Ramka1$grupaB,Ramka1$grupaA,Ramka1$Poziom,las=1,main="Wykresy interakcj")

pairwise.t.test(Ramka1$Poziom,g=Ramka1$grupaA)


#Zadanie2
plon1=c(4.5,4.9,5.4);plon2=c(5.2,5.4,5.9);
plon3=c(5.3,5.5,5.8);plon4=c(4.7,5.1,5.8);
plon5=c(5.6,6.1,5.7);plon6=c(5.1,5.0,5.6);
plon7=c(5.1,6.0,5.7);plon8=c(5.2,4.8,5.5);
plon9=c(5.2,5.3,5.9)

lista2=list(plon1,plon2,plon3,plon4,plon5,plon6,plon7,plon8,plon9)
bartlett.test(lista2)

Pszenica=rep(c("Pszenica1","Pszenica2","Pszenica3"),c(9,9,9))
Nawoz=rep(rep(c("Nawoz1","Nawoz2","Nawoz3"),c(3,3,3)),3)
Poziom1=c(plon1,plon2,plon3,plon4,plon5,plon6,plon7,plon8,plon9)

Ramka2=data.frame(Poziom1,Pszenica,Nawoz)

boxplot(Poziom1~Pszenica,data=Ramka2,las=1,col=5)
boxplot(Poziom1~Nawoz,data=Ramka2,las=1,col=5)

analiza2=aov(Poziom1~Pszenica*Nawoz,data=Ramka2)
summary(analiza2)

Nawoz1=as.factor(Ramka2$Nawoz)
Pszenica1=as.factor(Ramka2$Pszenica)
ramka2=data.frame(Poziom1,Pszenica1,Nawoz1)

plot.design(ramka2,las=1)

interaction.plot(Ramka2$Pszenica,Ramka2$Nawoz,Ramka2$Poziom1,las=1,main="Wykresy interakcj")

interaction.plot(Ramka2$Nawoz,Ramka2$Pszenica,Ramka2$Poziom1,las=1,main="Wykresy interakcj")

pairwise.t.test(Ramka2$Poziom1,g=Ramka2$Pszenica)
