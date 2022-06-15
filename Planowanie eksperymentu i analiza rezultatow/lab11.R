
sym1=function(n){
  roznica=numeric()
  for(i in c(1:n)){
    x1=sample(c(0,1),size=705,replace=T,prob = c(0.53,0.47))
    x2=sample(c(0,1),size=1320,replace=T,prob=c(0.53,0.47))
    roznica[i]=sum(x1)-sum(x2)
  }
  return(roznica)
}

dane1=sym1(1000)
hist(dane1,las=1)
range(dane1)
dane1b=table(dane1)
barplot(dane1b/sum(dane1b),las=1,col=2)

shapiro.test(dane1)
qqnorm(dane1)
qqline(dane1)

#Zadanie5
#braki
braki=c(12,18,6,8)

proby=c(1000,1000,1000,1000)

prop.test(braki,proby)

pairwise.prop.test(braki,proby)
barplot(braki/proby,las=1,col=2,ylim=c(0,0.02))

#zadanie 6

zachorowania=c(57,142)
liczba=c(200745,200745)

prop.test(zachorowania,liczba,alternative = "less")
