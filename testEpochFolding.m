%test epoch folding
clear all;
close all;
clc;

maindir = '/home/jose/UNIVERSIDAD/EL4106/proyectoGP';
    directories={'CEPH','EB','RRL'};
    periodFiles={'CEPH_periods.txt','EB_periods.txt','RRL_periods.txt'};
    %Primero abrimos los archivos .txt que contienen los periodos
    %'*_periods.txt' y lo guardamos en una matriz. Cada coluna de la matriz
    %corresponde a un tipo (CEPH, 
    periods=[];
    for i=1:length(periodFiles)
       fid=fopen(periodFiles{i});
       p=readPeriod(fid);
       periods=[periods, p];
       fclose(fid);
    end


fid=fopen('/home/jose/UNIVERSIDAD/EL4106/proyectoGP/CEPH/lc_1.3441.15_blue');

read=readMACHOFile(fid);

subplot(2,1,1);
plot(read(:,1),read(:,2));
title('Sin epoch Folding');

fold=epochFolding(read, periods(1,1));
subplot(2,1,2);
plot(fold(:,1),fold(:,2));
title('Con epoch Folding');
fclose(fid);
