Man=c(116,115,108,103,102,129,112,109,108,114,75,117)
length(Man)
mean(Man)
summary(Man)

Lim=c(61,77,88,76,84,66,79,62,62,71,82,84)
mean(Lim)
summary(Lim)

ks.test(Man,Lim)

qqplot(Man,Lim,las=1,asp=1)
abline(0,1)

plot(ecdf(Man),las=1)
lines(ecdf(Lim),las=1,col=2)
boxplot(Man,las=1)
boxplot(list(Man,Lim),col=5,las=1)
summary(Lim)

dev.off()
m1=mean(Man)
m2=mean(Lim)

s1=sd(Man)
s1
s2=sd(Lim)

qqnorm(Man,las=1)
qqline(Man)

qqnorm(Lim,las=1)
qqline(Lim)

shapiro.test(Man)
shapiro.test(Lim)

ks.test(Man,"pnorm",m1,s1)

plot(ecdf(Man),las=1)
arg=seq(70,150)
wart=pnorm(arg,m1,s1)
lines(arg,wart,col=2,lwd=2)
h=hist(Man,las=1)
str(h)

dev.off()

probka=c(5.8,16,4.7,7.2,8.9,8.8,11.6,19.9,65.5,93,67,50,22,73.9,59.7)

ks.test(probka,"punif",0,100)
plot(ecdf(probka),las=1)
arg=seq(0,100,0.1)
wart=punif(arg,0,100)
lines(arg,wart,col=2,lwd=2)
plot(qunif(ppoints(probka),0,100),sort(probka),las=1,asp = 1)
abline(0,1)

set.seed(28)
x=rexp(20,0.1)
ks.test(x,"pexp",0.1)

Sym1=function(n,m){
  stat=numeric()
  for(i in c(1:n)){
    los=rexp(m,0.1)
      k=ks.test(los,"pexp",0.1)
      stat[i]=k$statistic
  }
  return(stat)
}

dane=Sym1(100,50)
dane
h=hist(dane,las=1,xlim=c(0,0.5))


Sym2=function(n,m){
  stat1=numeric()
  stat2=numeric()
  for(i in c(1:n)){
    los1=rexp(m,0.1)
    k1=ks.test(los1,"pexp",0.1)
    stat1[i]=k1$statistic
    
    los2=rexp(m,0.1)
    k2=ks.test(los2,"pexp",0.1)
    stat2[i]=k2$statistic
  }
  lis=list(stat1,stat2)
  return(lis)
}

dane2=Sym2(100,20)
par(mfrow=c(1,2))
h1=hist(dane2[[1]])
h2=hist(dane2[[2]])
dev.off()

qqplot(dane2[[1]],dane2[[2]],las=1)
abline(0,1)
ks=ks.test(dane2[[1]],dane2[[2]])
str(ks)

Sym3=function(n,m){
  pv=numeric()
  for(i in c(1:n)){
    los=rexp(m,0.1)
    k=ks.test(los,"pexp",0.1)
    pv[i]=k$p.value
  }
  return(pv)
}

dane3=Sym3(100,20)
dane3
hist(dane3,las=1)
length(which(dane3>0.05))

ks.test(dane3,"punif",0,1)
plot(qunif(ppoints(dane3),0,1),sort(dane3))

z=runif(100,0,50)
par(mfrow=c(2,3))
par(mfg=c(1,2))
boxplot(z,col=2)
