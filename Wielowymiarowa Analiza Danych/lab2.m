r=corrcoef(Horsepower,Weight,'Rows','complete');
disp(r);
varnames=["Moc","Masa "];
corrplot(r,'varNames',varnames);


figure(2);
r2=corrcoef(MPG,Horsepower,'Rows','pairwise');
varnames2=["MPG","Moc"];
corrplot(r2,'varNames',varnames2);

figure(3);
r3=corrcoef(Acceleration,Displacement,'Rows','complete');
varnames3=["przys","pojem"];
corrplot(r3,'varNames',varnames3);
disp(r3)


