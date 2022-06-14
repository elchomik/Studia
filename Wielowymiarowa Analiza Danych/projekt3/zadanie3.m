dane=readtable("Dane 2010-2017.xlsx");

data=table2array(dane(:,"Data"));
ropa=table2array(dane(:,"CenaRopyNaftowejUSD_bary_ka"));
kursWalutowy=table2array(dane(:,"KursWalutowyUSD_PLN"));
cenaHurtowa=table2array(dane(:,"CenaHurtowaPB95PLN_litr"));
cenaDetaliczna=table2array(dane(:,"CenaDetalicznaPB95PLN_litr"));

timeTableDane=table2timetable(dane);

dominanta=mode(table2array(dane(:,"CenaDetalicznaPB95PLN_litr")));
%boxplot(ropa,dominanta);
%xlabel('Najczęściej występująca wartość PB95');
%ylabel('Cena ropy naftowej');

%figure(2);
%boxplot(kursWalutowy,dominanta);
%xlabel('Najczęściej występująca wartość PB95');
%ylabel('Kurs walutowy');


%zadanie 3
proba1=corrcoef(ropa(1:27),cenaDetaliczna(1:27));
proba2=corrcoef(ropa(28:54),cenaDetaliczna(28:54));
proba3=corrcoef(ropa(55:79),cenaDetaliczna(55:79));
proba4=corrcoef(ropa(80:106),cenaDetaliczna(80:106));
proba5=corrcoef(ropa(107:132),cenaDetaliczna(107:132));
proba6=corrcoef(ropa(133:158),cenaDetaliczna(133:158));
proba7=corrcoef(ropa(159:184),cenaDetaliczna(159:184));
proba8=corrcoef(ropa(185:210),cenaDetaliczna(185:210));
proba9=corrcoef(ropa(211:236),cenaDetaliczna(211:236));
proba10=corrcoef(ropa(237:262),cenaDetaliczna(237:262));
proba11=corrcoef(ropa(263:288),cenaDetaliczna(263:288));
proba12=corrcoef(ropa(289:314),cenaDetaliczna(289:314));
proba13=corrcoef(ropa(315:340),cenaDetaliczna(315:340));
proba14=corrcoef(ropa(341:367),cenaDetaliczna(341:367));
proba15=corrcoef(ropa(368:405),cenaDetaliczna(368:405));

WK1=[proba1(2),proba2(2),proba3(2),proba4(2),proba5(2),proba6(2),proba7(2),proba8(2),proba9(2),proba10(2),proba11(2),proba12(2),proba13(2),proba14(2),proba15(2)];


proba_b1=corrcoef(ropa(1:27),kursWalutowy(1:27));
proba_b2=corrcoef(ropa(28:54),kursWalutowy(28:54));
proba_b3=corrcoef(ropa(55:79),kursWalutowy(55:79));
proba_b4=corrcoef(ropa(80:106),kursWalutowy(80:106));
proba_b5=corrcoef(ropa(107:132),kursWalutowy(107:132));
proba_b6=corrcoef(ropa(133:158),kursWalutowy(133:158));
proba_b7=corrcoef(ropa(159:184),kursWalutowy(159:184));
proba_b8=corrcoef(ropa(185:210),kursWalutowy(185:210));
proba_b9=corrcoef(ropa(211:236),kursWalutowy(211:236));
proba_b10=corrcoef(ropa(237:262),kursWalutowy(237:262));
proba_b11=corrcoef(ropa(263:288),kursWalutowy(263:288));
proba_b12=corrcoef(ropa(289:314),kursWalutowy(289:314));
proba_b13=corrcoef(ropa(315:340),kursWalutowy(315:340));
proba_b14=corrcoef(ropa(341:367),kursWalutowy(341:367));
proba_b15=corrcoef(ropa(368:405),kursWalutowy(368:405));

WK2=[proba_b1(2),proba_b2(2),proba_b3(2),proba_b4(2),proba_b5(2),proba_b6(2),proba_b7(2),proba_b8(2),proba_b9(2),proba_b10(2),proba_b11(2),proba_b12(2),proba_b13(2),proba_b14(2),proba_b15(2)];

proba_c1=corrcoef(kursWalutowy(1:27),cenaDetaliczna(1:27));
proba_c2=corrcoef(kursWalutowy(28:54),cenaDetaliczna(28:54));
proba_c3=corrcoef(kursWalutowy(55:79),cenaDetaliczna(55:79));
proba_c4=corrcoef(kursWalutowy(80:106),cenaDetaliczna(80:106));
proba_c5=corrcoef(kursWalutowy(107:132),cenaDetaliczna(107:132));
proba_c6=corrcoef(kursWalutowy(133:158),cenaDetaliczna(133:158));
proba_c7=corrcoef(kursWalutowy(159:184),cenaDetaliczna(159:184));
proba_c8=corrcoef(kursWalutowy(185:210),cenaDetaliczna(185:210));
proba_c9=corrcoef(kursWalutowy(211:236),cenaDetaliczna(211:236));
proba_c10=corrcoef(kursWalutowy(237:262),cenaDetaliczna(237:262));
proba_c11=corrcoef(kursWalutowy(263:288),cenaDetaliczna(263:288));
proba_c12=corrcoef(kursWalutowy(289:314),cenaDetaliczna(289:314));
proba_c13=corrcoef(kursWalutowy(315:340),cenaDetaliczna(315:340));
proba_c14=corrcoef(kursWalutowy(341:367),cenaDetaliczna(341:367));
proba_c15=corrcoef(kursWalutowy(368:405),cenaDetaliczna(368:405));

WK3=[proba_c1(2),proba_c2(2),proba_c3(2),proba_c4(2),proba_c5(2),proba_c6(2),proba_c7(2),proba_c8(2),proba_c9(2),proba_c10(2),proba_c11(2),proba_c12(2),proba_c13(2),proba_c14(2),proba_c15(2)];

%hold on;
%plot(WK1,Color='blue');
%plot(WK2,Color='red');
%plot(WK3,Color='green');
%xlabel('Liczba próbek danych (dane z 6 miesięcy)');
%ylabel('Wartość współczynnika korelacji');
%legend({'WK1','WK2','WK3'},'Location','west');
%hold off;


%zadanie 4

ropaFun=detrend(ropa);
kursFun=detrend(kursWalutowy);
cenaDetalicznaFun=detrend(cenaDetaliczna);

WK1fun=detrend(WK1);
WK2fun=detrend(WK2);
WK3fun=detrend(WK3);
%hold on;
%plot(ropaFun,Color='red');
%plot(kursFun,Color='blue');
%plot(cenaDetalicznaFun,Color='green');
%stem(ropaFun);
%stem(kursFun);
%stem(cenaDetalicznaFun);
%bar(ropaFun);
%bar(kursFun);
%bar(cenaDetalicznaFun);
%plot(WK1fun);
%plot(WK2fun);
%plot(WK3fun);
%stem(WK1fun);
%stem(WK2fun);
%stem(WK3fun);
%bar(WK1fun);
%bar(WK2fun);
%bar(WK3fun);
%xlabel('Liczba próbek danych');
%ylabel('Wartość współczynnika korelacji');
%title('Wykres zależności wartości współczynnika korelacji');
%legend({'WK1','WK2','WK3'},'Location','west');
%hold off;

%zadanie 5

szacowaniePB95=ropa.*kursWalutowy./159;
szacunTrend=detrend(szacowaniePB95);

hold on;
plot(szacunTrend);
plot(cenaDetalicznaFun);
title('Wykres funkcji trendowego');
xlabel('Ilość danych');
ylabel('Wartość detaliczna PB95');
legend({'Cena przybliżona obliczona','Cena detaliczna Pb95'});
hold off;

%zadanie 6

%hold on;
%subplot(3,1,1);
%histogram(WK1,FaceColor='auto');
%title("Histogram dla współczynników korelacji");
%ylabel('Ilość próbek');
%xlabel('Wartość współczynnika korelacji');
%legend({'WK1'});
%hold off;
%subplot(3,1,2);
%histogram(WK2,FaceColor="auto");
%hold on;
%title("Histogram dla współczynników korelacji");
%ylabel('Ilość próbek');
%xlabel('Wartość współczynnika korelacji');
%legend({'WK2'});
%hold off;
%subplot(3,1,3);
%histogram(WK3,FaceColor="auto");
%title("Histogram dla współczynników korelacji");
%ylabel('Ilość próbek');
%xlabel('Wartość współczynnika korelacji');
%legend({'WK3'});
%hold off;

%hold on;
%subplot(3,1,1);
%boxplot(WK1);
%title("Histogram dla współczynników korelacji WK-1");
%xlabel('Ilość próbek');
%ylabel('WK-1');
%hold off;
%subplot(3,1,2);
%boxplot(WK2);
%hold on;
%title("Histogram dla współczynników korelacji WK-2");
%xlabel('Ilość próbek');
%ylabel('WK-2');
%hold off;
%subplot(3,1,3);
%boxplot(WK3);
%title("Histogram dla współczynników korelacji WK-3");
%xlabel('Ilość próbek');
%ylabel('WK-3');
%hold off;

%b

%hold on;
%subplot(3,1,1);
%probplot(WK1);
%title("Wykres korelacji WK-1");
%xlabel('Ilość próbek');
%ylabel('WK-1');
%hold off;
%subplot(3,1,2);
%probplot(WK2);
%hold on;
%title("Wykres korelacji WK-2");
%xlabel('Ilość próbek');
%ylabel('WK-2');
%hold off;
%subplot(3,1,3);
%probplot(WK3);
%title("Wykres korelacji WK-3");
%xlabel('Ilość próbek');
%ylabel('WK-3');
%hold off;


%hold on;
%subplot(3,1,1);
%qqplot(WK1);
%title("Wykres korelacji WK-1");
%xlabel('Ilość próbek');
%ylabel('WK-1');
%hold off;
%subplot(3,1,2);
%qqplot(WK2);
%hold on;
%title("Wykres korelacji WK-2");
%xlabel('Ilość próbek');
%ylabel('WK-2');
%hold off;
%subplot(3,1,3);
%qqplot(WK3);
%title("Wykres korelacji WK-3");
%xlabel('Ilość próbek');
%ylabel('WK-3');
%hold off;

%zadanie 7
%plot(data,cenaDetaliczna);
%title('Wykres zależności Ceny Detalicznej od czasu');
%ylabel('Wartość PB95');
%xlabel('Okres czasu');

plot(data,ropa);
title('Wykres zależności ceny ropy nafotwej od czasu');
ylabel('Wartość USD/PLN dla baryłki');
xlabel('Okres czasu');

figure(2);
autocorr(ropa,NumLags=404);
title('Wykres zależności dla współczynnika autokorelacji dla ropy naftowej');
xlabel('Ilość opóźnień');
ylabel('Wartość współczynnika autokorelacji');

%figure(2);
%plot(autokorelacjaCenaDetaliczna);
%xlabel('Ilość danych');
%ylabel('Wartość współczynnika korelacji');
%title('Wykres zależności współczynnika korelacji od ilości danych');