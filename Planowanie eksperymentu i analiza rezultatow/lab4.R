#CTG n liczba symulacji(œcie¿ek), m wielkoœæ sumy
ctg=function(n,m)
{
  sum=numeric()
  los=runif(m,min=0,max=1)
  sum[1]=sum(los)
  tytul="Suma, X1+X2+..."
  plot(c(1:m),cumsum(los),type="l",main=tytul,ylim=c(0,200),
       las=1,cex.axis=0.75)
  if(n>1)
  {
    for(i in c(2:n)){
      los=runif(m,0,1)
      sum[i]=sum(los)
      lines(c(1:m),cumsum(los),type="l")
    }
  }
  return(sum)
}

ctg(1,100)
ctg(2,100)
ctg(5,100)
ctg(100,100)
par(mfrow=c(1,3))
plane=ctg(100,100)
hist(plane,las=1)
dane2=(plane-min(plane))/sd(plane)
range(dane2)
hist(dane2,las=1,xlim=c(-4,4),freq=F)
arg=seq(-3,3,0.1)
wart=dnorm(arg)
lines(arg,wart,col=2,lwd=2)

cumean=function(v){
  l=length(v)
  u=cumsum(v)
  for(i in c(1:l)){
    u[i]=u[i]/i
  }
  return(u)
}

v=c(1,1,1,1,0)
cumean(v)
cumean(c(1,2,3,4))

pwl=function(n,m){
  los=runif(m,0,100)
  plot(c(1:m),cumean(los),type="l",ylim=c(0,100),las=1,cex.axis=0.75)
  if(n>1){
    for(i in c(2:n)){
      los=runif(m,0,100)
      lines(c(1:m),cumean(los),type="l")
    }
  }
}


pwl(1,100)
pwl(2,100)
pwl(100,100)
dev.off()

pwl(100,1000)
abline(h=50,col=2,lwd=2)
kostka=c(10,7,14,6,7,6)
h=chisq.test(kostka)
str(h)
chi2=function(kostka){
  h=chisq.test(kostka)
  M=rbind(h$observed,h$expected)
  tytul=paste("chi-kw=",h$statistic,", p.value=",round(h$p.value,2))
  barplot(M,beside=T,col=c(2,5),las=1,space=c(0.2,1),main=tytul,names.arg=c(1:length(kostka)))
}

chi2(kostka)
chisq.test(c(10,10,10,10,10,10))
chi2(c(30,10,10,10,10,10))


Test1=function(n,m){
  ws=numeric()
  for(i in c(1:n)){
    rzut=sample(c(1:6),m,replace=T)
    rzut2=table(rzut)
    h=chisq.test(rzut2)
    ws[i]=h$statistic
  }
  return(ws)
}
dane=Test1(250,100)
range(dane)
hist(dane,las=1,freq = F,ylim=c(0,0.2))
arg=seq(0,20,0.1)
wart=dchisq(arg,5)
lines(arg,wart,col=2,lwd=2)
