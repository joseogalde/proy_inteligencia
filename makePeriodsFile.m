%% Crea el archivo .mat con la lista de los periodos

%Cambiar por carpeta donde se descomprimio MACHO.zip
maindir = '/home/jose/UNIVERSIDAD/EL4106/proyectoGP';
%[periods, stars] = loadPeriods(maindir);
periods = loadPeriods(maindir);
rc = comparelist;

if rc == 0  %todo OK
save 'periods.mat' periods
%graficar el histograma de los periodos

rango=0:0.4:15;
hist(periods,rango);
title('Histograma del Periodos de las MACHO');
legend('CEPH','EB','RRL');
else
    disp('Error: Las duplas (estrella,periodo) no estan correctamente pareadas');
end