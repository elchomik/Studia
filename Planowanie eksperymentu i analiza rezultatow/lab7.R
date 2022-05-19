pom=read.csv2(file.choose(),header=TRUE,sep=";")
head(pom,n=10)
tail(pom)
str(pom)
summary(pom)
boxplot(Waga~Plantacja,data = pom)
waga=pom$Waga
plant=pom$Plantacja
names(waga)=plant
waga
kruskal.test(Waga~Plantacja,data=pom)
mean(waga[names(waga)=="A"])
mean(waga[names(waga)=="B"])
mean(waga[names(waga)=="C"])
mean(waga[names(waga)=="D"])

Rangi=rank(waga)
Rangi
sort(Rangi)
mean(Rangi)
mean(Rangi[names(waga)=="A"])
mean(Rangi[names(waga)=="B"])
mean(Rangi[names(waga)=="C"])
mean(Rangi[names(waga)=="D"])

k1=rnorm(100,0,1)
k2=sample(LETTERS,100,replace = T)
k3=sample(month.name,100,replace=T)
k1
k2
k3
data=data.frame(liczby=k1,litery=k2,miesiace=k3)
data
getwd()
write.csv2(data,file="ramka.csv",row.names = F)
write.csv(data,file="ramka2.csv",sep=",",dec=".")

x1=runif(20,0,20)
x2=rnorm(20,10,33)
x3=rexp(18,1/8)
list1=list(x1,x2,x3)
boxplot(list1,las=1,boxwex=0.5,col=5,horizontal=T)
kruskal.test(list1)



powiaty=read.csv2(file.choose(),header=TRUE,sep=";")
head(powiaty)
tail(powiaty)

plot(powiaty$pow,powiaty$lud,las=1)
plot(powiaty$pow,powiaty$lud,las=1,ylim=c(0,500000))

cor(powiaty$pow,powiaty$lud)
summary(powiaty$pow)
gr1=c(0.600,1200,3000)
pow1=cut(powiaty$pow,breaks = gr1)
abline(v=gr1,col=2)
summary(powiaty$lud)
gr2=c(19000,50000,80000,2000000)
lud1=cut(powiaty$lud,breaks = gr2)
abline(h=gr2,col=2)
tabela1=table(pow1,lud1)

chisq.test(tabela1)

library(TeachingDemos)

chisq.detail(tabela1)

miasta=read.csv2(file.choose(),header=TRUE,sep=";")
head(miasta)
tail(miasta)

plot(miasta$pow,miasta$lud,las=1,xlim=c(0,100),ylim=c(0,100000))
cor(miasta$pow,miasta$lud)
b=boxplot(miasta$lud,horizontal = T,ylim=c(0,200000))
median(miasta$lud)
mean(miasta$lud)
abline(v=mean(miasta$lud),col=2)
quantile(miasta$lud,0.9)
hist(miasta$lud,breaks = 30)

barplot(sort(powiaty$lud,decreasing = T),las=1)

powiaty[c(1,3,5),]
head(powiaty[order(powiaty$lud,decreasing = T),])
head(powiaty[order(powiaty$pow,decreasing = T),])

ramka=HairEyeColor
ramka
Male=ramka[,,1]
Male
Female=ramka[,,2]
Female

chisq.test(Male)

cyfra=function(x,n){
  y=as.character(abs(x))
  d=substr(y,n,n)
  d2=as.numeric(d)
  return(d2)
}

cyfra(-5638,1)
