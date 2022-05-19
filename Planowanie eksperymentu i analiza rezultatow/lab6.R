fun=function(n){
  switch(n,"A","B","C")
}

fun(2)

kupon=c(1,2,3,4,5,6)

lotto=function(kupon,n){
  wygrane=c(0,0,0,0,0,0,0)
  names(wygrane)=c(0:6)
  for(i in c(1:n)){
    los=sample(c(1:49),6,replace=F)
    trafione=length(intersect(kupon,los))+1
    switch(trafione,
      {wygrane[1]=wygrane[1]+1},
    {wygrane[2]=wygrane[2]+1},
    {wygrane[3]=wygrane[3]+1},
    {wygrane[4]=wygrane[4]+1},
    {wygrane[5]=wygrane[5]+1},
    {wygrane[6]=wygrane[6]+1},
    {wygrane[7]=wygrane[7]+1})
  }
  wygrane2=round(wygrane/n,3)
  tytul=paste("Liczba losowañ=",n)
  b=barplot(wygrane2,col=2,las=1,ylim=c(0,1),
            names=c(0:6),main=tytul)
  text(b,wygrane2+0.1,labels=wygrane2,xpd=T,cex=0.8)
  return(wygrane)
  }
  
lotto(kupon,100)
lotto(c(1:12),10000)

arg=seq(-300,300,0.1)
wart=dnorm(arg,0,100)
plot(arg,wart,las=1,type="l",ylim=c(0,0.001))


library(randtests)
x1=c(1:20)
runs.test(x1,plot=T)
median(x1)
x2=c(1,2,3,4,5,6,12,8,9,10,11,7)
runs.test(x2,plot=T)
x3=runif(26,0,1)
runs.test(x3,plot=T)

seria=function(n,m){
  s=numeric()
  for(i in c(1:n)){
    proba=runif(m,0,1)
    h=runs.test(proba)
    s[i]=h$runs
  }
  return(s)
}

dane1=seria(100,1000)
hist(dane1,las=1)
summary(dane1)
shapiro.test(dane1)
qqnorm(dane1)
qqline(dane1,col=7)
gen1=seq(0,1,0.01)
plot(gen1,rep(0,length(gen1)),pch=16)
ks.test(gen1,"punif",0,1)
runs.test(gen1,plot=7)

modulo=function(x,n){
  u=numeric()
  u[1]=x
  for(i in c(2:n)){
    u[i]=(133*u[i-1])%%1
  }
  return(u)
}


dane2=modulo(3.4,10)
dane2
runs.test(dane2,plot=T)
ks.test(dane2,"punif",0,1)
plot(ecdf(dane2))
arg=seq(0,1,0.1)
wart=punif(arg,0,1)
lines(arg,wart,col=2,lwd=2)


p1=rnorm(20,100,30)
p2=rnorm(10,100,30)
p3=rnorm(25,100,30)
p4=rnorm(30,100,30)
p5=rnorm(15,100,30)
lista3=list(p1,p2,p3,p4,p5)
boxplot(lista3,las=1,main="N(100,30)",boxwex=0.5,col=5)
kruskal.test(lista3)
