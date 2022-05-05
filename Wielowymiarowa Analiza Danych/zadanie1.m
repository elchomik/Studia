boxplot(MPG,Origin)
title('Zależność spalania paliwa od kraju z którego pochodzi samochód')
xlabel('Kraj')
ylabel('MPG')



[x,y]=meshgrid(Weight,Acceleration);
z=meshgrid(MPG,Weight);
mesh(x,y,z);
xlabel('Masa')
ylabel('Przyspieszenie')
zlabel('MPG')

%figure(2)
boxplot(MPG,Cylinders)
xlabel('Cylindry');
ylabel('MPG');







%figure(3)
boxplot(Acceleration,Origin);
title('Wykres zależności kraju od przyspieszenia');
xlabel('Kraj');
ylabel('Przyspieszenie');

%figure(4)
boxplot(Weight,Origin);
title('Wykres zależności kraju od przyspieszenia');
xlabel('Kraj');
ylabel('Waga samochodu');

%figure(5)
boxplot(Horsepower,Origin);
title('Wykres zależności kraju od mocy samochodu');
xlabel('Kraj');
ylabel('Moc samochodu');


[przyspieszenie,moc_silnika]=corrcoef(Acceleration,Horsepower,'Rows','pairwise');
plot(przyspieszenie,moc_silnika);
xlabel('przyspieszenie');
ylabel('moc silnika');

WholeHorsepower=fillmissing(Horsepower,'linear');

wykres=table(Mfg,Horsepower,Displacement);
sortWykres=sortrows(wykres);
unikalnaMarka=unique(Mfg,'rows','first');
[unikalneDane,ia]=unique(sortWykres.Mfg,'rows','first');
wyniki=sortWykres(ia,:);
disp(wyniki);
wyniki.Mfg=cellstr(wyniki.Mfg);
wyniki.Mfg=categorical(wyniki.Mfg);
bar(wyniki.Mfg,wyniki.Horsepower);
title('Wykres zaleznosci najmniejszej mocy od modelu');
xlabel('Mfg');
ylabel('Horsepower');


CylindryMasa=[Weight,Cylinders];
posortowaneCylindryMasa=sort(CylindryMasa);
posortowanePrzyspieszenie=sort(Acceleration);
plot(posortowanePrzyspieszenie,posortowaneCylindryMasa);
title('Wykres zależności przyspieszenia od ilości cylindrów i masy');
xlabel('Przyspieszenie');
ylabel('Cylindry i Masa');


scatter3(Horsepower,Acceleration,MPG);
xlabel('Horsepower');
ylabel('Acceleration');
zlabel('MPG');

wypelnijMPG=fillmissing(MPG,'linear');
zad10=table(Mfg,Weight,Acceleration,wypelnijMPG,Model_Year);
zad10.Mfg=cellstr(zad10.Mfg);
zad10.mfg=categorical(zad10.Mfg);
amcTable=zad10(strcmp(zad10.Mfg,'amc'),:);
disp(amcTable);

figure(2);
plot(amcTable.Model_Year,amcTable.wypelnijMPG);
title('Wykres zaleznosci MPG od Model Year dla AMC');
xlabel('Model Year');
ylabel('MPG');

figure(3);
plot(amcTable.Model_Year,amcTable.Weight);
title('Wykres zaleznosci Masy od Model Year');
xlabel(' Model Year');
ylabel(' Weight');

figure(4);
plot(amcTable.Model_Year,amcTable.Acceleration);
title('Wykres zaleznosci Przyspieszenia od Model Year');
xlabel('Model Year');
ylabel('Acceleration');

