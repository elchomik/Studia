w1=c(1,-1,4,-4,9,25,36)
w1[20]=333
w1
w2=sqrt(w1)
w2
sum(w2,na.rm=T)

mean(c(1,2,3,NA),na.rm=T)
max(c(1,2,3,NA),na.rm=T)
sin(c(1,2,3,4))

log2(c(1,2,3,4))
set.seed(45)
kostka=sample(c(1:6),100,replace = T)
kostka
unique(kostka)
kostka2=table(kostka)
kostka2

is.table(kostka2)
sum(kostka2)
names(kostka2)
letters
LETTERS
los3=sample(LETTERS,100,T)

los4=table(los3)
los4

sum(los4)
los5=sample(c(1,2,3),20,replace=T,prob=c(0.6,0.2,0.2))
los5
los6=table(los5)
los6
los7=sample(c("O","R"),100,T)
los8=table(los7)
los8


a=c(1,5,20,60)
b=c(10,20,3,15)
plot(a,b)
plot(a,b,xlim=c(0,100),ylim=c(0,50),las=1)
plot(a,b,xlim=c(0,100),ylim=c(0,50),las=1,type="o",cex=2)
plot(a,b,xlim=c(0,100),ylim=c(0,100),las=1,type="p",xlab="argumenty",ylab="wartoœci",main="wykres 1",asp=1)

a2=c(5,40,80)
b2=c(30,20,3)

lines(a2,b2,col=2,pch=16,cex=2)
points(c(-5,30,90),c(50,10,40),col=6,pch=16,bg=2,cex=4)
plot(a,b,xlim=c(0,100),ylim=c(0,100),las=1,type="n",asp=1)
abline(0,1,lty=3,lwd=3)
abline(0,2,lty=1,lwd=5)
abline(0,3,lty=2,lwd=4)
abline(0,4,lty=4,lwd=2)
abline(1,2,lty=2,lwd=2)
abline(h=30,lty=2,col=5,lwd=2)
abline(v=c(-10,0,10,20,50))
abline(h=c(20,40,50),col=2)

a=c(1,50,100)
b=c(10,127,40)

P=list(x=a,y=b)
plot(P,las=1,xlim=c(0,200),ylim=c(0,150),type="n")
Punkty=locator(n=5,type="o")
Punkty

x1=Punkty[[1]]
x2=Punkty[[2]]
x1
x2
points(Punkty)
punkty2=locator(n=5,type="p")
points(punkty2,col=3,cex=4)


x=c(1,5,10,20)
y=c(10,7,23,4)
P=list(x=x,y=y)
P
plot(P,ann=F,axes=F,xlim=c(-5,50))
axis(1,at=c(-2,10,30),labels=c("a","b","c"))
axis(2,las=1)
title(xlab="argumenty",ylab="wartoœci",main="ABCD")
box()

x=seq(-10,10,0.01)
x
y=sin(x)
plot(x,y,"p")

t=seq(0,2*pi,length.out=100)
t
x1=cos(t)
y1=sin(t)
plot(x1,y1,las=1,"l",asp=1)

a=5>0
b=(5==3)
c=(5!=3)
d=(3>1)&&(5>2)
e=(3>1)||(5>10)
e
d
f=!e
f
w=c(-1,0,3,6,7,8,-9,-10,44)
w2=w>0
w2
ind=which(w>0)
ind
w[ind]
w[w>0]

a=c(-1,1,0,0)
b=c(-2,4,-1,8)

ind2=which((a==0) & (b==0))
ind2


fun2=function(x)
{
  y=x*sin(x)
  return(y)
}

arg=seq(-10,10,0.1)
fun2(1)
(fun2(1.3))^4
log(1+sin(cos(sin(cos(6)))))
fun2(fun2(fun2(5)))
wart=fun2(arg)
plot(arg,wart,las=1,"l")
