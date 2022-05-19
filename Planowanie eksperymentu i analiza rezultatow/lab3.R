kwadrat=function(n,k=1,m=1){
  x=runif(n,0,1)
  y=runif(n,0,1)
  tytul=paste(n,"punktow w kwadracie")
  plot(x,y,xlim=c(0,1),ylim=c(0,1),las=1,main=tytul,pch=k,col=m)
}

kwadrat(10,16,2)

fun2=function(x){
  y=numeric()
  if(x>=0) y=x^2
  else y=-x
  return (y)
}

fun2(-5)
fun2(5)
arg=seq(-5,5,0.1)
fun2(arg)

wart=sapply(arg,fun2)
wart

plot(arg,wart,las=1,type='l',lwd=2)

Fib=function(n)
{
  u=numeric()
  u[1]=1
  u[2]=1
  for(i in c(3:n)){
    u[i]=u[i-1]+u[i-2]
  }
  return (u)
}

v=Fib(10)
sum(v)


v1=c(1,1,2,3,4,5,5,6)
v2=c(1,1,2,2)
v3=c(10)


intersect(v1,v2)
intersect(v2,v3)

print(paste("wektor=",c(1,2,3)))
cat("wektor=",c(1,2,3))
cat("wektor=",c(1,2,3),"abcd")

set.seed(14)

Lotto=function(kupon){
los=sample(c(1:49),6,replace =F)
traf=length(intersect(kupon,los))
cat("Twoje liczby: ",sort(kupon),"\n")
cat(" Losowanie: ",sort(los),"\n")
cat(" Ilosc trafionych: ",traf,"\n")
}

Lotto(c(5,7,10,20,30,41))

dane=rnorm(50,mean=1000,sd=100)
dane
range(dane)
h=hist(dane,xlim=c(700,1300),las=1,freq = T)
str(h)
mean(dane)
lines(dane,rep(0,length(dane)),type="p",pch=16,cex=1)

weighted.mean(h$mids,h$counts)
mean(dane)
abline(v=mean(dane),col=2,lwd=2)

jedn=runif(60,min=50,max=100)
jedn
range(jedn)

h2=hist(jedn,las=1,xlim=c(40,110),ylim=c(0,16))

points(jedn,rep(0,length(jedn)),pch=16,cex=0.8)

text(h2$mids,h2$counts+1,labels=h2$counts,cex=0.8)
str(h2)


#Histogramy chi-kwadrat
chi=rchisq(100,df=10)
  chi
range(chi)  

h3=hist(chi,freq=F,breaks=15,las=1,xlim=c(0,30),ylim=c(0,0.15))
points(chi,rep(0,length(chi)),pch=16,cex=1)
x=seq(0,25,0.1)
y=dchisq(x,df=10)
lines(x,y,type="l",col=2,lwd=2)
abline(v=mean(chi),col=2)

abline(v=median(chi),col=3)


#dystrybuanta empiryczna
chi=rchisq(100,df=10)
chi
sort(chi)
plot(ecdf(chi),las=1,ylim=c(0,1.1),xlim=c(0,20))

x=seq(0,25,0.1)
y=pchisq(x,df=10)
lines(x,y,col=2,lwd=2)


chi2=rchisq(15,df=10)
plot(ecdf(chi2),las=1,ylim=c(0,1.1))
x1=seq(0,30,0.1)
y1=pchisq(x1,df=10)
lines(x1,y1,col=2,lwd=2)


k1=rchisq(20,df=5)
k2=rchisq(20,df=5)
k3=rchisq(20,df=10)
plot(ecdf(k1),las=1,ylim=c(0,1.1))
lines(ecdf(k2),col=2)
lines(ecdf(k3),col=3)


proba=rchisq(14,df=10)
proba
plot(ecdf(proba),las=1)
sort(proba)
abline(h=0.27,col=2,lwd=2)
quantile(proba,0.27)

ctg<-function(n,m){
  sum=numeric()
  los=runif(m,min=0,max=1)
  sum[1]=sum(los)
  tytul="Suma X1+X2+..."
  plot(c(1:m),sumsum(los),type="l",main=tytul,ylim=c(0,200),las=1,cex.axis=0.75)
  if(n>1){
    for(i in c(2:n)){
      los=runif(m,0,1)
      sum[i]=sum(los)
      lines(c(1:m),cumsum(los),type="l")
    }
  }
  return(sum)
}