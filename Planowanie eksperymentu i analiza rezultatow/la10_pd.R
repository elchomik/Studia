#Praca domowa
#zad1 - test chi-kwadrat
#zadanie z ruletk¹ wróciæ

#zad2
#wartoœæ oczekiwana dla rozk³adu Poissona, polecenie waited-mean
#zgodnoœæ z rozk³adu Poisson z chi-kwadrat, policzyæ prawdopodobieñstwa
#d-dla rozk³adow ci¹g³ych
#wykres barplot

#zad4
#metoda momentóW, policzyæ sredni¹, lambda 1/œrednia
#przy rozk³adzie chi-kwadrat, parametr szacowany przez œredni¹, wykorzystaæ parametr n w rozk³adzie ks

#zad5
#wykorzystaæ funkcje cyfra, zbadaæ test niezal¿nosci, test kontengencji polecenie table

#zad6
#wykres piramidowy,

#zad7
#
#
#

#zadanie1
s=rolldie(4,makespace=T)
head(s,n=10)
tail(s)

A=subset(s,X1+X2+X3+X4>=12)

prob(A)

B=subset(s,X1+X2+X3+X4<=15)
prob(B)

prob(intersect(A,B))

prob(union(A,B))
prob(setdiff(A,B))
prob(A,given=B)

C=subset(s,(X1+X2+X3+X4)%%2==0)
prob(C)
D=subset(s,X1*X2*X3*X4>=10)
prob(D)

prob(C,given=D)


#Zadanie2

R=rolldie(3)

R["X1+X2+X3"]=R$X1+R$X2+R$X3
R["X1*X2*X3"]=R$X1*R$X2*R$X3
head(R)

R["œrednia"]=apply(R[,c(1,2,3)],1,mean)
R[218,]=apply(R[c(1:216),],2,mean)
head(R)
tail(R)


W=rolldie(3)
W["X1+X2+X3"]=W$X1+W$X2+W$X3
W["X1*X2*X3"]=W$X1*W$X2*W$X3

Suma=table(W$ 'X1+X2+X3')
Suma

barplot(Suma,col = 3,las=1)

Iloczyn=table(W$ 'X1*X2*X3')

barplot(Iloczyn,las=1,col=2)

Iloczyn=table(R$ 'X1*X2*X3')

#Zadanie3
#wykresy skrzypcowe
x1=rnorm(30.0,15)
x2=rnorm(35,100,15)
x3=rnorm(30,200,20)

x=c(x1,x2,x3)
hist(x,las=1,breaks=25)
par(mfrow=c(1,2))
boxplot(x,las=1,col=3)
vioplot(x,las=1,col=5,horizontal=F)
dev.off()

#Zadanie4
#wykresy dwuwymiarowe
a=c(1,2,3)
b=c(1,2,3,4)

o1=outer(a,b)
o1

o2=outer(a,b,"/")
o2

fun1<-function(x,y){
  exp(-1*(x^2+y^2))
}

x1=seq(-3,3,0.2)
y1=seq(-2,2,0.2)
z1=outer(x1,y1,fun1)
persp(x1,y1,z1,theta=20,phi=15,scale=F,expand=2,col=5,ticktype="detailed",r=10)

fun2<-function(x,y){
  x^2*y^2*exp(-1*(x^2+y^2))
}

x2=seq(-2,2,0.2)
y2=seq(-3,3,0.2)
z2=outer(x2,y2,fun2)

persp(x2,y2,z2,theta=45,phi=25,scale=F,expand=10,col=5,main="wykresy 3d",r=10)
contour(x2,y2,z2,asp=1,drawlabels=F,nlevels=20)
filled.contour(x2,y2,z2,color.palette=terrain.colors,asp=1)

fun3<-function(x,y){
  3*x-4*y+5
}
z3=outer(x1,y1,fun3)
persp(x1,y1,z3,theta=25,phi=15,scale=F,expand=0.2,col=5)
contour(x1,y1,z3,asp=1,drawlabels=F,nlevels=20)
filled.contour(x1,y1,z3,color.palette=terrain.colors,asp=1)

fun4<-function(x,y){
  x^2+y^2
}

x=seq(-10,10,0.5)
y=seq(-10,10,0.5)
z=outer(x,y,fun4)
contour(x,y,z,las=1,asp=1,drawlabels = F,nlevels=25,lwd=2)
filled.contour(x,y,z,color.palette=terrain.colors,asp=1)
persp(x,y,z,theta=30,phi=15,scale = F,expand=0.1,ticktype = "detailed",cex.axis=0.8,col=8)

#Zadanie5
t=seq(0,2*pi,length.out=6)
x=cos(t); y=sin(t)

plot(x,y,las=1,asp=1,type="n")
polygon(x,y)
x5=c(-1,2,5,6,4)
y5=c(1,10,7,3,7)
plot(x5,y5,las=1,asp=1,type="n")
polygon(x5,y5,col=5)

#Zadanie6
x=rnorm(100,0,5)
y=runif(100,-8,8)
plot(x,y,las=1,asp=1,pch=16)
plot(x,y,las=1,asp=1,col=ifelse((x>0&y>0),"red","black"),pch=16)
