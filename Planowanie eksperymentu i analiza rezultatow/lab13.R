#Zadanie3 vel 1 przedzia³y ufnoœci zadanie1

#przedzia³ ufnoœci dla nieznancyh danych czy coœ rozklad normalny parametry m,s
#przedzia³ ufnoœci dla œredniej:
#t1-alpha/2(k-1) jest kwantylem rzêdu 1-alpha/2 rozk³adu t-studenta o k-1 stopniach swobody
#standardowo alpha=0,05
#qt dla t-studenta qt(0,975,df=k-1)
#qchis dla chis


puNorm=function(n,k,m,s){
  dol=numeric() #dolna granica
  gor=numeric() #gorna granica
  estym=numeric()
  for(i in c(1:n)){
    x=rnorm(k,m,s)
    wyr=sd(x)*qt(0.975,df=k-1)/sqrt(k-1)
    dol[i]=mean(x)-wyr #ograniczenie dolne przedzialu ufnoœci
    gor[i]=mean(x)+wyr #ograniczenie górne przedzia³u ufnoœci
    estym[i]=mean(x) #œrednia z próbki
  }
  plotCI(c(1:n),estym,ui=gor,li=dol,las=1,xlab="",ylab="",
       ylim=c(m-2*s,m+2*s),
       main="przedzia³y ufnoœci",
       xaxt="n")
  axis(side=1,at=c(1,n),labels=T,cex.axis=0.75)
  abline(h=m,lty=2,col="red")
}

puNorm(50,9,100,16)
puNorm(50,16,100,16)
puNorm(50,30,100,16)
puNorm(50,100,100,16)
puNorm(50,150,100,16)
puNorm(50,1000,100,16)


#Zadanie 2 (5 wariancji)

#najpierw test normalnoœci jeœli tak to 

tech1=c(63,39,66,65,60,43,37)
tech2=c(35,54,38,25,24,22,37)
tech3=c(75,62,42,43,27,81,66)
tech4=c(69,58,40,68,51,25,23)
tech5=c(44,46,25,59,31,38,32)

shapiro.test(tech1)
shapiro.test(tech2)
shapiro.test(tech3)
shapiro.test(tech4)
shapiro.test(tech5)

#test bartleta dla wielu wariancji jeœli maj¹ rozk³ad normalny
bartlett.test(list(tech1,tech2,tech3,tech4,tech5))

#test Levena w przypadku braku normalnoœci, musi byc podzia³ na kategorie
library(lawstat)

grupy=c(rep(1,length(tech1)),rep(2,length(tech2)),rep(3,length(tech3)),
        rep(4,length(tech4)),rep(5,length(tech5)))
levene.test(c(tech1,tech2,tech3,tech4,tech5),grupy)

#test Flignera
fligner.test(list(tech1,tech2,tech3,tech4,tech5))
