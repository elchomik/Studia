dane=readtable("z2.xls","NumHeaderLines",1);
sredniaCzestosc1=table2array(dane(:,"Cz_sto__Przeskok_w_Pole1"));
sredniaCzestosc2=table2array(dane(:,"Cz_sto__Przeskok_w_Pole2"));
sredniaCzestosc3=table2array(dane(:,"Cz_sto__Przeskok_w_Pole3"));
sredniaCzestosc4=table2array(dane(:,"Cz_sto__Przeskok_w_Pole4"));

%vect1=table2array(sredniaCzestosc1);
%vect2=table2array(sredniaCzestosc2);
%vect3=table2array(sredniaCzestosc3);
%vect4=table2array(sredniaCzestosc4);

sredniaCzestosc=sredniaCzestosc1+sredniaCzestosc2+sredniaCzestosc3+sredniaCzestosc4/4;

napiecieElektrolitu1=table2array(dane(:,"Napi_cieElektrofiltru_Pole1"));
napiecieElektrolitu2=table2array(dane(:,"Napi_cieElektrofiltru_Pole2"));
napiecieElektrolitu3=table2array(dane(:,"Napi_cieElektrofiltru_Pole3"));
napiecieElektrolitu4=table2array(dane(:,"Napi_cieElektrofiltru_Pole4"));

sredniaNapiecieElektrolitu=napiecieElektrolitu4+napiecieElektrolitu2+napiecieElektrolitu3+napiecieElektrolitu1/4;

cisnieniePrzedFiltrem1=table2array(dane(:,"Ci_nienieSpalinPrzedElektrofiltrem_StronaLewa"));
cisnieniePrzedFiltrem2=table2array(dane(:,"Ci_nienieSpalinPrzedElektrofiltrem_StronaPrawa"));

srednieniePrzedFiltrem=cisnieniePrzedFiltrem2+cisnieniePrzedFiltrem1/2;

cisnienieZaFiltrem1=table2array(dane(:,"Ci_nienieSpalinZaElektrofiltrem_StronaLewa"));
cisnieZaFiltrem2=table2array(dane(:,'Ci_nienieSpalinZaElektrofiltrem_StronaPrawa'));

srednieZaFiltrem=cisnienieZaFiltrem1+cisnieZaFiltrem2/2;

stezeniePylu1=table2array(dane(:,"St__eniePy_uNaWylocie_StronaLewa"));
stezeniePylu2=table2array(dane(:,"St__eniePy_uNaWylocie_StronaPrawa"));

srednieStezeniePylu=stezeniePylu1+stezeniePylu2/2;

proba1=corrcoef(sredniaCzestosc(1:500),sredniaNapiecieElektrolitu(1:500),'Rows','complete');
proba2=corrcoef(sredniaCzestosc(501:1000),sredniaNapiecieElektrolitu(501:1000),'Rows','complete');
proba3=corrcoef(sredniaCzestosc(1001:1500),sredniaNapiecieElektrolitu(1001:1500),'Rows','complete');
proba4=corrcoef(sredniaCzestosc(1501:2000),sredniaNapiecieElektrolitu(1501:2000),'Rows','complete');
proba5=corrcoef(sredniaCzestosc(2001:2500),sredniaNapiecieElektrolitu(2001:2500),'Rows','complete');
proba6=corrcoef(sredniaCzestosc(2501:3003),sredniaNapiecieElektrolitu(2501:3003),'Rows','complete');

z=[proba1(3),proba2(3),proba3(3),proba4(3),proba5(3),proba6(3)];
%disp(z)

%plot(z);
%xlabel('Numer próby');
%ylabel('Wartość współczynnika korelacji')
%title('Zależność częstotliwości przeskoków od napięcia elektrolitu');

pradElektrolitu1=table2array(dane(:,"Pr_dElektrofiltru_Pole1"));
pradEektrolitu2=table2array(dane(:,"Pr_dElektrofiltru_Pole2"));
pradElektrolitu3=table2array(dane(:,"Pr_dElektrofiltru_Pole3"));
pradEektrolitu4=table2array(dane(:,"Pr_dElektrofiltru_Pole4"));

sredniPradElektrolitu=pradElektrolitu1+pradEektrolitu2+pradElektrolitu3+pradEektrolitu4/4;

%proba1=corrcoef(sredniPradElektrolitu(1:500),sredniaNapiecieElektrolitu(1:500),'Rows','pairwise');
%proba2=corrcoef(sredniPradElektrolitu(501:1000),sredniaNapiecieElektrolitu(501:1000),'Rows','pairwise');
%proba3=corrcoef(sredniPradElektrolitu(1001:1500),sredniaNapiecieElektrolitu(1001:1500),'Rows','pairwise');
%proba4=corrcoef(sredniPradElektrolitu(1501:2000),sredniaNapiecieElektrolitu(1501:2000),'Rows','pairwise');
%proba5=corrcoef(sredniPradElektrolitu(2001:2500),sredniaNapiecieElektrolitu(2001:2500),'Rows','pairwise');
%proba6=corrcoef(sredniPradElektrolitu(2501:3003),sredniaNapiecieElektrolitu(2501:3003),'Rows','pairwise');

%z=[proba1(3),proba2(3),proba3(3),proba4(3),proba4(3),proba5(3),proba6(3)];
%plot(z);
%xlabel('Numer próbki ( w każdej próbce po 500 wyników)');
%ylabel('Wartość współczynnika korelacji');
%title('Wykres zależności prądu elektrolitów od napięcia elektrolitów');

tempSpalinWlot1=table2array(dane(:,"Temp_SpalinNaWlocie_StronaLewa"));
tempSpalinWlot2=table2array(dane(:,"Temp_SpalinNaWlocie_StronaPrawa"));
sredniaTempSpalinWlot=tempSpalinWlot1+tempSpalinWlot2/2;

mocCieplna=table2array(dane(:,"MocCieplna_Suma"));


tempSpalinWylot1=table2array(dane(:,"Temp_SpalinNaWylocie_StronaLewa"));
tempSpalinWylot2=table2array(dane(:,"Temp_SpalinNaWylocie_StronaPrawa"));
sredniaTempSpalinWylot=tempSpalinWylot1+tempSpalinWylot2/2;

pr1=corrcoef(sredniaCzestosc(1:500),sredniaTempSpalinWlot(1:500),'Rows','pairwise');
pr2=corrcoef(sredniaCzestosc(501:1000),sredniaTempSpalinWlot(501:1000),'Rows','pairwise');
pr3=corrcoef(sredniaCzestosc(1001:1500),sredniaTempSpalinWlot(1001:1500),'Rows','pairwise');
pr4=corrcoef(sredniaCzestosc(1501:2000),sredniaTempSpalinWlot(1501:2000),'Rows','pairwise');
pr5=corrcoef(sredniaCzestosc(2001:2500),sredniaTempSpalinWlot(2001:2500),'Rows','pairwise');
pr6=corrcoef(sredniaCzestosc(2501:3003),sredniaTempSpalinWlot(2501:3003),'Rows','pairwise');

z=[pr1(3),pr2(3),pr3(3),pr4(3),pr5(3),pr6(3)];


%figure(2);
pro1=corrcoef(sredniaCzestosc(1:500),sredniaTempSpalinWylot(1:500),'Rows','pairwise');
pro2=corrcoef(sredniaCzestosc(501:1000),sredniaTempSpalinWylot(501:1000),'Rows','pairwise');
pro3=corrcoef(sredniaCzestosc(1001:1500),sredniaTempSpalinWylot(1001:1500),'Rows','pairwise');
pro4=corrcoef(sredniaCzestosc(1501:2000),sredniaTempSpalinWylot(1501:2000),'Rows','pairwise');
pro5=corrcoef(sredniaCzestosc(2001:2500),sredniaTempSpalinWylot(2001:2500),'Rows','pairwise');
pro6=corrcoef(sredniaCzestosc(2501:3003),sredniaTempSpalinWylot(2501:3003),'Rows','pairwise');

%z2=[pro1(3),pro2(3),pro3(3),pro4(3),pro5(3),pro6(3)];
%x=[1,2,3,4,5,6];
%hold on;
%plot(z);
%plot(z2,'--');
%hold off;
%xlabel('Liczba próbek (500 danych w próbce)');
%ylabel('Współczynnik korelacji');
%title('Wykres zależności częstotliwości skoków od temperatury spalin na wlocie i wylocie');

%figure(2);
%da1=corrcoef(sredniaTempSpalinWlot(1:500),sredniaTempSpalinWylot(1:500),'Rows','pairwise');
%da2=corrcoef(sredniaTempSpalinWlot(501:1000),sredniaTempSpalinWylot(501:1000),'Rows','pairwise');
%da3=corrcoef(sredniaTempSpalinWlot(1001:1500),sredniaTempSpalinWylot(1001:1500),'Rows','pairwise');
%da4=corrcoef(sredniaTempSpalinWlot(1501:2000),sredniaTempSpalinWylot(1501:2000),'Rows','pairwise');
%da5=corrcoef(sredniaTempSpalinWlot(2001:2500),sredniaTempSpalinWylot(2001:2500),'Rows','pairwise');
%da6=corrcoef(sredniaTempSpalinWlot(2501:3003),sredniaTempSpalinWylot(2501:3003),'Rows','pairwise');

%z3=[da1(3),da2(3),da3(3),da4(3),da5(3),da6(3)];
%plot(z3);
%xlabel('Liczba próbek (po 500 w próbce)');
%ylabel('Wartość współczynnika korelacji');
%title('Wykres zależności temp wlotu od temp wylotu');

%Korelacja pomiędzy moc cieplna stęzenie pylu
ascMoc=sort(mocCieplna,'ascend');
ascStezeniePylu=sort(srednieStezeniePylu,'asc');
ascSredniaCzestosc=sort(sredniaCzestosc,'asc');
ascSredniPrad=sort(sredniPradElektrolitu,'ascend');
ascSredniaTempWlot=sort(sredniaTempSpalinWylot,'ascend');
ascSredniaTempWylot=sort(sredniaTempSpalinWylot,'ascend');
ascSredniaZaFiltrem=sort(srednieZaFiltrem,'ascend');
ascSredniaPrzedFiltrem=sort(srednieniePrzedFiltrem,'ascend');
ascSrednieNapiecie=sort(sredniaNapiecieElektrolitu,'ascend');

da1=corrcoef(ascSredniaCzestosc(1:500),ascSredniaTempWylot(1:500),'Rows','pairwise');
da2=corrcoef(ascSredniaCzestosc(501:1000),ascSredniaTempWylot(501:1000),'Rows','pairwise');
da3=corrcoef(ascSredniaCzestosc(1001:1500),ascSredniaTempWylot(1001:1500),'Rows','pairwise');
da4=corrcoef(ascSredniaCzestosc(1501:2000),ascSredniaTempWylot(1501:2000),'Rows','pairwise');
da5=corrcoef(ascSredniaCzestosc(2001:2500),ascSredniaTempWylot(2001:2500),'Rows','pairwise');
da6=corrcoef(ascSredniaCzestosc(2501:3003),ascSredniaTempWylot(2501:3003),'Rows','pairwise');

dan1=corrcoef(ascMoc(1:500),ascSredniaTempWylot(1:500),'Rows','pairwise');
dan2=corrcoef(ascMoc(501:1000),ascSredniaTempWylot(501:1000),'Rows','pairwise');
dan3=corrcoef(ascMoc(1001:1500),ascSredniaTempWylot(1001:1500),'Rows','pairwise');
dan4=corrcoef(ascMoc(1501:2000),ascSredniaTempWylot(1501:2000),'Rows','pairwise');
dan5=corrcoef(ascMoc(2001:2500),ascSredniaTempWylot(2001:2500),'Rows','pairwise');
dan6=corrcoef(ascMoc(2501:3003),ascSredniaTempWylot(2501:3003),'Rows','pairwise');

da_1=corrcoef(ascSredniPrad(1:500),ascSredniaTempWylot(1:500),'Rows','pairwise');
da_2=corrcoef(ascSredniPrad(501:1000),ascSredniaTempWylot(501:1000),'Rows','pairwise');
da_3=corrcoef(ascSredniPrad(1001:1500),ascSredniaTempWylot(1001:1500),'Rows','pairwise');
da_4=corrcoef(ascSredniPrad(1501:2000),ascSredniaTempWylot(1501:2000),'Rows','pairwise');
da_5=corrcoef(ascSredniPrad(2001:2500),ascSredniaTempWylot(2001:2500),'Rows','pairwise');
da_6=corrcoef(ascSredniPrad(2501:3003),ascSredniaTempWylot(2501:3003),'Rows','pairwise');

da_1a=corrcoef(ascSredniaTempWlot(1:500),ascSredniaTempWylot(1:500),'Rows','pairwise');
da_2a=corrcoef(ascSredniaTempWlot(501:1000),ascSredniaTempWylot(501:1000),'Rows','pairwise');
da_3a=corrcoef(ascSredniaTempWlot(1001:1500),ascSredniaTempWylot(1001:1500),'Rows','pairwise');
da_4a=corrcoef(ascSredniaTempWlot(1501:2000),ascSredniaTempWylot(1501:2000),'Rows','pairwise');
da_5a=corrcoef(ascSredniaTempWlot(2001:2500),ascSredniaTempWylot(2001:2500),'Rows','pairwise');
da_6a=corrcoef(ascSredniaTempWlot(2501:3003),ascSredniaTempWylot(2501:3003),'Rows','pairwise');

da_1b=corrcoef(ascStezeniePylu(1:500),ascSredniaTempWylot(1:500),'Rows','pairwise');
da_2b=corrcoef(ascStezeniePylu(501:1000),ascSredniaTempWylot(501:1000),'Rows','pairwise');
da_3b=corrcoef(ascStezeniePylu(1001:1500),ascSredniaTempWylot(1001:1500),'Rows','pairwise');
da_4b=corrcoef(ascStezeniePylu(1501:2000),ascSredniaTempWylot(1501:2000),'Rows','pairwise');
da_5b=corrcoef(ascStezeniePylu(2001:2500),ascSredniaTempWylot(2001:2500),'Rows','pairwise');
da_6b=corrcoef(ascStezeniePylu(2501:3003),ascSredniaTempWylot(2501:3003),'Rows','pairwise');

da_1c=corrcoef(ascSredniaZaFiltrem(1:500),ascSredniaTempWylot(1:500),'Rows','pairwise');
da_2c=corrcoef(ascSredniaZaFiltrem(501:1000),ascSredniaTempWylot(501:1000),'Rows','pairwise');
da_3c=corrcoef(ascSredniaZaFiltrem(1001:1500),ascSredniaTempWylot(1001:1500),'Rows','pairwise');
da_4c=corrcoef(ascSredniaZaFiltrem(1501:2000),ascSredniaTempWylot(1501:2000),'Rows','pairwise');
da_5c=corrcoef(ascSredniaZaFiltrem(2001:2500),ascSredniaTempWylot(2001:2500),'Rows','pairwise');
da_6c=corrcoef(ascSredniaZaFiltrem(2501:3003),ascSredniaTempWylot(2501:3003),'Rows','pairwise');

da_1d=corrcoef(ascSredniaPrzedFiltrem(1:500),ascSredniaTempWylot(1:500),'Rows','pairwise');
da_2d=corrcoef(ascSredniaPrzedFiltrem(501:1000),ascSredniaTempWylot(501:1000),'Rows','pairwise');
da_3d=corrcoef(ascSredniaPrzedFiltrem(1001:1500),ascSredniaTempWylot(1001:1500),'Rows','pairwise');
da_4d=corrcoef(ascSredniaPrzedFiltrem(1501:2000),ascSredniaTempWylot(1501:2000),'Rows','pairwise');
da_5d=corrcoef(ascSredniaPrzedFiltrem(2001:2500),ascSredniaTempWylot(2001:2500),'Rows','pairwise');
da_6d=corrcoef(ascSredniaPrzedFiltrem(2501:3003),ascSredniaTempWylot(2501:3003),'Rows','pairwise');

da_1e=corrcoef(ascSrednieNapiecie(1:500),ascSredniaTempWylot(1:500),'Rows','pairwise');
da_2e=corrcoef(ascSrednieNapiecie(501:1000),ascSredniaTempWylot(501:1000),'Rows','pairwise');
da_3e=corrcoef(ascSrednieNapiecie(1001:1500),ascSredniaTempWylot(1001:1500),'Rows','pairwise');
da_4e=corrcoef(ascSrednieNapiecie(1501:2000),ascSredniaTempWylot(1501:2000),'Rows','pairwise');
da_5e=corrcoef(ascSrednieNapiecie(2001:2500),ascSredniaTempWylot(2001:2500),'Rows','pairwise');
da_6e=corrcoef(ascSrednieNapiecie(2501:3003),ascSredniaTempWylot(2501:3003),'Rows','pairwise');

z=[da1(3),da2(3),da3(3),da4(3),da5(3),da6(3)];
z2=[dan1(3),dan2(3),dan3(3),dan4(3),dan5(3),dan6(3)];
z3=[da_1(3),da_2(3),da_3(3),da_4(3),da_5(3),da_6(3)];
z4=[da_1a(3),da_2a(3),da_3a(3),da_4a(3),da_5a(3),da_6a(3)];
z5=[da_1b(3),da_2b(3),da_3b(3),da_4b(3),da_5b(3),da_6b(3)];
z6=[da_1c(3),da_2c(3),da_3c(3),da_4c(3),da_5c(3),da_6c(3)];
z7=[da_1d(3),da_2d(3),da_3d(3),da_4d(3),da_5d(3),da_6d(3)];
z8=[da_1e(3),da_2e(3),da_3e(3),da_4e(3),da_5e(3),da_6e(3)];
%hold on;
%plot(z,'-*');
%plot(z2,'--');
%plot(z3,'--',Color='blue');
%plot(z4,'-o',Color='red');
%plot(z5,'-o',Color='magenta');
%plot(z6,'-o',Color='green');
%plot(z7,'-o',Color='blue');
%plot(z8,'-o',Color='cyan');
%hold off;
%xlabel('Liczba próbek (po 500 w próbce)');
%ylabel('Wartość współczynnika korelacji');
%title('Wykres przedstawiający zależność temperatury spalin od dowolnego innego czynnika ');
%legend

%zadanie6
dan1_=corrcoef(ascMoc(1:500),ascStezeniePylu(1:500),'Rows','pairwise');
dan2_=corrcoef(ascMoc(501:1000),ascStezeniePylu(501:1000),'Rows','pairwise');
dan3_=corrcoef(ascMoc(1001:1500),ascStezeniePylu(1001:1500),'Rows','pairwise');
dan4_=corrcoef(ascMoc(1501:2000),ascStezeniePylu(1501:2000),'Rows','pairwise');
dan5_=corrcoef(ascMoc(2001:2500),ascStezeniePylu(2001:2500),'Rows','pairwise');
dan6_=corrcoef(ascMoc(2501:3003),ascStezeniePylu(2501:3003),'Rows','pairwise');

zad6=[dan1_(3),dan2_(3),dan3_(3),dan3_(4),dan4_(3),dan5_(3),dan6_(3)];

%plot(zad6,'--');
%xlabel('Numer próbki (po 500 danych w jednej próbce)');
%ylabel('Wartość współczynnika korelacji');
%title('Wykres zależności mocy cieplnej od stężenia pyłu');

%figure(2);
moc1=ascMoc(1:500);
moc2=ascMoc(501:1000);
moc3=ascMoc(1001:1500);
moc4=ascMoc(1501:2000);
moc5=ascMoc(2001:2500);
moc6=ascMoc(2501:3003);

%zad6a=[moc1,moc2,moc3,moc4,moc5,moc6];
%hold on
%plot(ascMoc);
%plot(ascStezeniePylu);
%hold off;
%xlabel('Liczba próbek');
%ylabel('Wartość średniej mocy oraz średniego pyłu');
%title('Wykres zależnośći stężenia pyłu oraz mocy cieplnej od liczby próbek');

%zadanie 7
A(:,1)=ascMoc(1:500);
A(:,2)=ascStezeniePylu(1:500);
A(:,3)=ascSredniaTempWylot(1:500);

B(:,1)=ascMoc(501:1000);
B(:,2)=ascStezeniePylu(501:1000);
B(:,3)=ascSredniaTempWylot(501:1000);


C(:,1)=ascMoc(1001:1500);
C(:,2)=ascStezeniePylu(1001:1500);
C(:,3)=ascSredniaTempWylot(1001:1500);

D(:,1)=ascMoc(1501:2000);
D(:,2)=ascStezeniePylu(1501:2000);
D(:,3)=ascSredniaTempWylot(1501:2000);

E(:,1)=ascMoc(2001:2500);
E(:,2)=ascStezeniePylu(2001:2500);
E(:,3)=ascSredniaTempWylot(2001:2500);

F(:,1)=ascMoc(2501:3003);
F(:,2)=ascStezeniePylu(2501:3003);
F(:,3)=ascSredniaTempWylot(2501:3003);

dan1_1=corrcoef(A,'Rows','pairwise');
dan2_2=corrcoef(B,'Rows','pairwise');
dan3_3=corrcoef(C,'Rows','pairwise');
dan4_4=corrcoef(D,'Rows','pairwise');
dan5_5=corrcoef(E,'Rows','pairwise');
dan6_6=corrcoef(F,'Rows','pairwise');

mocStezenie=[dan1_1(2),dan2_2(2),dan3_3(2),dan4_4(2),dan5_5(2),dan6_6(2)];
mocTemp=[dan1_1(3),dan2_2(3),dan3_3(3),dan4_4(3),dan5_5(3),dan6_6(3)];
stezenieTemp=[dan1_1(8),dan2_2(8),dan3_3(8),dan4_4(8),dan5_5(8),dan6_6(8)];

%hold on;
%plot(mocStezenie,'--',Color='red');
%plot(mocTemp,'--',Color='yellow');
%plot(stezenieTemp,'--',Color='green');
%hold off;
%xlabel('Liczba próbek (po 500 w próbce)');
%ylabel('Wartość współczynnika korelacji dla mocy, stężenia, temp wylotu');
%title('Wykres powiązanych parametrów mocy, stężenia oraz temperatury wylotu');

ascPradElektrolitu1=sort(pradElektrolitu1,'ascend');
ascPradElektrolitu2=sort(pradEektrolitu2,'ascend');
ascPradElektrolitu3=sort(pradElektrolitu3,'ascend');
ascPradElektrolitu4=sort(pradEektrolitu4,'ascend');

A1(:,1)=ascPradElektrolitu1(1:500);
A1(:,2)=ascPradElektrolitu2(1:500);
A1(:,3)=ascPradElektrolitu3(1:500);
A1(:,4)=ascPradElektrolitu4(1:500);

B1(:,1)=ascPradElektrolitu1(501:1000);
B1(:,2)=ascPradElektrolitu2(501:1000);
B1(:,3)=ascPradElektrolitu3(501:1000);
B1(:,4)=ascPradElektrolitu4(501:1000);

C1(:,1)=ascPradElektrolitu1(1001:1500);
C1(:,2)=ascPradElektrolitu2(1001:1500);
C1(:,3)=ascPradElektrolitu3(1001:1500);
C1(:,4)=ascPradElektrolitu4(1001:1500);

D1(:,1)=ascPradElektrolitu1(1501:2000);
D1(:,2)=ascPradElektrolitu2(1501:2000);
D1(:,3)=ascPradElektrolitu3(1501:2000);
D1(:,4)=ascPradElektrolitu4(1501:2000);

E1(:,1)=ascPradElektrolitu1(2001:2500);
E1(:,2)=ascPradElektrolitu2(2001:2500);
E1(:,3)=ascPradElektrolitu3(2001:2500);
E1(:,4)=ascPradElektrolitu4(2001:2500);

F1(:,1)=ascPradElektrolitu1(2501:3003);
F1(:,2)=ascPradElektrolitu2(2501:3003);
F1(:,3)=ascPradElektrolitu3(2501:3003);
F1(:,4)=ascPradElektrolitu4(2501:3003);

dan1_1=corrcoef(A1,'Rows','complete');
dan2_2=corrcoef(B1,'Rows','complete');
dan3_3=corrcoef(C1,'Rows','complete');
dan4_4=corrcoef(D1,'Rows','complete');
dan5_5=corrcoef(E1,'Rows','complete');
dan6_6=corrcoef(F1,'Rows','complete');

prad12=[dan1_1(2),dan2_2(2),dan3_3(2),dan4_4(2),dan5_5(2),dan6_6(2)];
prad13=[dan1_1(3),dan2_2(3),dan3_3(3),dan4_4(3),dan5_5(3),dan6_6(3)];
prad14=[dan1_1(4),dan2_2(4),dan3_3(4),dan4_4(4),dan5_5(4),dan6_6(4)];
prad23=[dan1_1(7),dan2_2(7),dan3_3(7),dan4_4(7),dan5_5(7),dan6_6(7)];
prad24=[dan1_1(8),dan2_2(8),dan3_3(8),dan4_4(8),dan5_5(8),dan6_6(8)];
prad34=[dan1_1(12),dan2_2(12),dan3_3(12),dan4_4(12),dan5_5(12),dan6_6(12)];

%figure(2);
%hold on;
%plot(prad12,'--',Color='blue');
%plot(prad13,'--',Color='green');
%plot(prad14,'--',Color='yellow');
%plot(prad23,'-o',Color='red');
%plot(prad24,'-o',Color='cyan');
%plot(prad34,'-*',Color='black');
%hold off;
%xlabel('Liczba próbek (po 500 w próbce)');
%ylabel('Wartość współczynnika korelacji');
%title('Wykres zależności prądów elektrolitów 3 od 4 ');

%zadanie 9
ascStezenieWylotLewa=sort(stezeniePylu1,'ascend');
ascStezenieWylotPrawa=sort(stezeniePylu2,'ascend');
ascTempSpalinWylotLewa=sort(tempSpalinWylot1,'ascend');
ascTempSpalinWylotPrawa=sort(tempSpalinWylot2,'ascend');

dan1_=corrcoef(ascStezenieWylotLewa(1:500),ascTempSpalinWylotLewa(1:500),'Rows','pairwise');
dan2_=corrcoef(ascStezenieWylotLewa(501:1000),ascTempSpalinWylotLewa(501:1000),'Rows','pairwise');
dan3_=corrcoef(ascStezenieWylotLewa(1001:1500),ascTempSpalinWylotLewa(1001:1500),'Rows','pairwise');
dan4_=corrcoef(ascStezenieWylotLewa(1501:2000),ascTempSpalinWylotLewa(1501:2000),'Rows','pairwise');
dan5_=corrcoef(ascStezenieWylotLewa(2001:2500),ascTempSpalinWylotLewa(2001:2500),'Rows','pairwise');
dan6_=corrcoef(ascStezenieWylotLewa(2501:3003),ascTempSpalinWylotLewa(2501:3003),'Rows','pairwise');

dan1=corrcoef(ascStezenieWylotPrawa(1:500),ascTempSpalinWylotPrawa(1:500),'Rows','pairwise');
dan2=corrcoef(ascStezenieWylotPrawa(501:1000),ascTempSpalinWylotPrawa(501:1000),'Rows','pairwise');
dan3=corrcoef(ascStezenieWylotPrawa(1001:1500),ascTempSpalinWylotPrawa(1001:1500),'Rows','pairwise');
dan4=corrcoef(ascStezenieWylotPrawa(1501:2000),ascTempSpalinWylotPrawa(1501:2000),'Rows','pairwise');
dan5=corrcoef(ascStezenieWylotPrawa(2001:2500),ascTempSpalinWylotPrawa(2001:2500),'Rows','pairwise');
dan6=corrcoef(ascStezenieWylotPrawa(2501:3003),ascTempSpalinWylotPrawa(2501:3003),'Rows','pairwise');


wykres=[dan1_(2),dan2_(2),dan3_(2),dan4_(2),dan5_(2),dan6_(2)];
wykres2=[dan1(2),dan2(2),dan3(2),dan4(2),dan5(2),dan6(2)];

%figure(2);
%plot(wykres,'--',Color="red");
%xlabel('Liczba przedziałów (po 500 w przedziale)');
%ylabel('Wartość współczynnika korelacji');
%title("Wykres zależności temp spalin wylotu od stężenia pyłu po stronie lewej");
%legend({' pył od temp spalin'});

%figure(3);
%plot(wykres2,'--',Color="blue");
%xlabel('Liczba przedziałów (500 danych w przedziale)');
%ylabel('Wartość współczynnika korelacji');
%title('Wykres zależności temp spalin wylotu od stężenia pyłu po prawej stronie');

%zadanie 10

ascCzestosc1=sort(sredniaCzestosc1,'ascend');
ascCzesosc2=sort(sredniaCzestosc2,'ascend');
ascCzestosc3=sort(sredniaCzestosc3,'ascend');
ascCzestosc4=sort(sredniaCzestosc4,'ascend');

A1(:,1)=ascCzestosc1(1:500);
A1(:,2)=ascCzesosc2(1:500);
A1(:,3)=ascCzestosc3(1:500);
A1(:,4)=ascCzestosc4(1:500);

B1(:,1)=ascCzestosc1(501:1000);
B1(:,2)=ascCzesosc2(501:1000);
B1(:,3)=ascCzestosc3(501:1000);
B1(:,4)=ascCzestosc4(501:1000);

C1(:,1)=ascCzestosc1(1001:1500);
C1(:,2)=ascCzesosc2(1001:1500);
C1(:,3)=ascCzestosc3(1001:1500);
C1(:,4)=ascCzestosc4(1001:1500);

D1(:,1)=ascCzestosc1(1501:2000);
D1(:,2)=ascCzesosc2(1501:2000);
D1(:,3)=ascCzestosc3(1501:2000);
D1(:,4)=ascCzestosc4(1501:2000);

E1(:,1)=ascCzestosc1(2001:2500);
E1(:,2)=ascCzesosc2(2001:2500);
E1(:,3)=ascCzestosc3(2001:2500);
E1(:,4)=ascCzestosc4(2001:2500);

F1(:,1)=ascCzestosc1(2501:3003);
F1(:,2)=ascCzesosc2(2501:3003);
F1(:,3)=ascCzestosc3(2501:3003);
F1(:,4)=ascCzestosc4(2501:3003);

dan1_1=corrcoef(A1,'Rows','complete');
dan2_2=corrcoef(B1,'Rows','complete');
dan3_3=corrcoef(C1,'Rows','complete');
dan4_4=corrcoef(D1,'Rows','complete');
dan5_5=corrcoef(E1,'Rows','complete');
dan6_6=corrcoef(F1,'Rows','complete');

czestosc12=[dan1_1(2),dan2_2(2),dan3_3(2),dan4_4(2),dan5_5(2),dan6_6(2)];
czestosc13=[dan1_1(3),dan2_2(3),dan3_3(3),dan4_4(3),dan5_5(3),dan6_6(3)];
czestosc14=[dan1_1(4),dan2_2(4),dan3_3(4),dan4_4(4),dan5_5(4),dan6_6(4)];
czestosc23=[dan1_1(7),dan2_2(7),dan3_3(7),dan4_4(7),dan5_5(7),dan6_6(7)];
czestosc24=[dan1_1(8),dan2_2(8),dan3_3(8),dan4_4(8),dan5_5(8),dan6_6(8)];
czestosc34=[dan1_1(12),dan2_2(12),dan3_3(12),dan4_4(12),dan5_5(12),dan6_6(12)];

%figure(2);
%hold on;
%display(czestosc13);
%plot(czestosc12,'--',Color='blue');
%plot(czestosc13,'*',Color='green');
%plot(czestosc14,'*',Color='yellow');
%plot(czestosc23,'-o',Color='red');
%plot(czestosc24,'-o',Color='cyan');
%plot(czestosc34,'-*',Color='black');
%hold off;
%xlabel('Liczba próbek (po 500 w próbce)');
%ylabel('Wartość współczynnika korelacji');
%title('Wykres zależności przeskoków 3 od 4 ');

%zadanie 11
dan1=corrcoef(ascSredniaPrzedFiltrem(1:500),ascStezeniePylu(1:500),'Rows','pairwise');
dan2=corrcoef(ascSredniaPrzedFiltrem(501:1000),ascStezeniePylu(501:1000),'Rows','pairwise');
dan3=corrcoef(ascSredniaPrzedFiltrem(1001:1500),ascStezeniePylu(1001:1500),'Rows','pairwise');
dan4=corrcoef(ascSredniaPrzedFiltrem(1501:2000),ascStezeniePylu(1501:2000),'Rows','pairwise');
dan5=corrcoef(ascSredniaPrzedFiltrem(2001:2500),ascStezeniePylu(2001:2500),'Rows','pairwise');
dan6=corrcoef(ascSredniaPrzedFiltrem(2501:3003),ascStezeniePylu(2501:3003),'Rows','pairwise');

dane1=corrcoef(ascSredniaZaFiltrem(1:500),ascStezeniePylu(1:500),'Rows','pairwise');
dane2=corrcoef(ascSredniaZaFiltrem(501:1000),ascStezeniePylu(501:1000),'Rows','pairwise');
dane3=corrcoef(ascSredniaZaFiltrem(1001:1500),ascStezeniePylu(1001:1500),'Rows','pairwise');
dane4=corrcoef(ascSredniaZaFiltrem(1501:2000),ascStezeniePylu(1501:2000),'Rows','pairwise');
dane5=corrcoef(ascSredniaZaFiltrem(2001:2500),ascStezeniePylu(2001:2500),'Rows','pairwise');
dane6=corrcoef(ascSredniaZaFiltrem(2501:3003),ascStezeniePylu(2501:3003),'Rows','pairwise');

wykres=[dan1(2),dan2(2),dan3(2),dan4(2),dan5(2),dan6(2)];
wykres2=[dane1(2),dane2(2),dane3(2),dane4(2),dane5(2),dane6(2)];

%hold on;
%plot(wykres,'--',Color='red');
%plot(wykres2,'--',Color='green');
%xlabel('Liczba przedziałów (po 500 wartośći w przedziale)');
%ylabel('Wartość współczynika korelacji');
%title('Wykres zależnośći ciśnienia spalin na wlocie i wylocie od stężenia pyłu');
%hold off;

%zadanie 12
hold on
plot(ascMoc,Color='green');
plot(ascStezeniePylu,Color='blue');
xlabel('Liczba próbek danych');
ylabel('Wartość parametrów');
title('Wykres zależności mocy cieplnej oraz stężenia pyłu');
legend({'moc cieplna','stężenie pyłu'},'Location','west');
hold off;

%zadanie 13
dan1=corrcoef(ascSrednieNapiecie(1:500),sredniaCzestosc(1:500),'Rows','pairwise');
dan2=corrcoef(ascSrednieNapiecie(501:1000),sredniaCzestosc(501:1000),'Rows','pairwise');
dan3=corrcoef(ascSrednieNapiecie(1001:1500),sredniaCzestosc(1001:1500),'Rows','pairwise');
dan4=corrcoef(ascSrednieNapiecie(1501:2000),sredniaCzestosc(1501:2000),'Rows','pairwise');
dan5=corrcoef(ascSrednieNapiecie(2001:2500),sredniaCzestosc(2001:2500),'Rows','pairwise');
dan6=corrcoef(ascSrednieNapiecie(2501:3003),sredniaCzestosc(2501:3003),'Rows','pairwise');

wykres=[dan1(2),dan2(2),dan3(2),dan4(2),dan5(2),dan6(2)];
figure(2);

plot(wykres,Color='green');
xlabel('Liczba przedziałów próbek (500 w przedziale)');
ylabel('Współczynnik korelacji');
title('Wykres zależności częstotliwości przeskoków od napięcia elektrolitów');

figure(3)
hold on;
plot(ascSrednieNapiecie,Color='green');
plot(sredniaCzestosc);
xlabel('Liczba próbek');
ylabel('Wartość ');
title('Wykres zależności częstotliwości przeskoków od napięcia elektrolitów');
legend({'średnie napiecie','częstotliwość przeskoków'});
hold off;

