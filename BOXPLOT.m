clear;
clc;
FileName1 = ['D:\collage\battary\CODE\CODE\CSA\CSA_K.xlsx'];   
DataImport1 = readtable(FileName1);
Data1 = table2array(DataImport1);
[m, n] = size(Data1);

%load Data
PlotFrom            = 1;                      % number of data point 
PlotTo              = m;                % number of data point
R0_CSA = Data1(PlotFrom:PlotTo, 1);
R1_CSA = Data1(PlotFrom:PlotTo, 2);
C1_CSA = Data1(PlotFrom:PlotTo, 3);
R2_CSA = Data1(PlotFrom:PlotTo, 4);
C2_CSA = Data1(PlotFrom:PlotTo, 5);
C0_CSA = Data1(PlotFrom:PlotTo, 6);
RMSE_CSA = Data1(PlotFrom:PlotTo, 7);
TOC_CSA = Data1(PlotFrom:PlotTo, 9);

K_CSA=[(R0_CSA),(R1_CSA),(C1_CSA),(R2_CSA),(C2_CSA),(C0_CSA),(RMSE_CSA),(TOC_CSA)];

for i=1:8
    CSA_A(1,i)=max(K_CSA(i,1));
    CSA_A(2,i)=min(K_CSA(i,1));
    CSA_A(3,i)=mean(K_CSA(i,1));
end




FileName2= ['D:\collage\battary\CODE\CODE\CSA\PSO_K.xlsx'];   
DataImport2 = readtable(FileName2);
Data2 = table2array(DataImport2);
[m, n] = size(Data2);
R0_PSO = Data2(PlotFrom:PlotTo, 1);
R1_PSO = Data2(PlotFrom:PlotTo, 2);
C1_PSO = Data2(PlotFrom:PlotTo, 3);
R2_PSO = Data2(PlotFrom:PlotTo, 4);
C2_PSO = Data2(PlotFrom:PlotTo, 5);
C0_PSO = Data2(PlotFrom:PlotTo, 6);
RMSE_PSO = Data2(PlotFrom:PlotTo, 7);
TOC_PSO = Data2(PlotFrom:PlotTo, 9);

K_PSO=[(R0_PSO),(R1_PSO),(C1_PSO),(R2_PSO),(C2_PSO),(C0_PSO),(RMSE_PSO),(TOC_PSO)];

for i=1:8
    PSO_A(1,i)=max(K_PSO(i,1));
    PSO_A(2,i)=min(K_PSO(i,1));
    PSO_A(3,i)=mean(K_PSO(i,1));
end



figure(1);
boxplot([TOC_CSA,TOC_PSO],'Notch','on','labels',{'CSA','PSO'});
title('TIME');
ylabel('Time(sec)');

figure(2);
boxplot([R0_CSA,R0_PSO],'Notch','on','labels',{'CSA','PSO'});
title('R0');
ylabel('Ω');

figure(3);
boxplot([R1_CSA,R1_PSO],'Notch','on','labels',{'CSA','PSO'});
title('R1');
ylabel('Ω');

figure(4);
boxplot([R2_CSA,R2_PSO],'Notch','on','labels',{'CSA','PSO'});
title('R2');
ylabel('Ω');

figure(5);
boxplot([C0_CSA,C0_PSO],'Notch','on','labels',{'CSA','PSO'});
title('C0');
ylabel('F');

figure(6);
boxplot([C1_CSA,C1_PSO],'Notch','on','labels',{'CSA','PSO'});
title('C1');
ylabel('F');

figure(7);
boxplot([C2_CSA,C2_PSO],'Notch','on','labels',{'CSA','PSO'});
title('C2');
ylabel('F');

figure(8);
boxplot([RMSE_CSA,RMSE_PSO],'Notch','on','labels',{'CSA','PSO'});
title('RMSE');
ylabel('V');




