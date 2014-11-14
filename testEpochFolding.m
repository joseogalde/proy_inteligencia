%test epoch folding
clear all;
close all;
clc;

maindir = '/home/jose/UNIVERSIDAD/EL4106/proyectoGP';
cd(maindir);

 periods = loadPeriods(maindir);
directories={'CEPH','EB','RRL'};
 
%i=randi(length(directories));
i=3;
disp(['Directorio : ',directories{i}]);
switch i
    case 1
        dirname = 'CEPH';
    case 2
        dirname = 'EB';
    case 3
        dirname = 'RRL';
end
j=randi(500);
disp(['Numero de archivo : ',num2str(j)]);
        %Nos movemos a una de las carpetas CEPH, EB o RRL y vamos abriendo
        %cada uno de los archivos dentro de ellas
        cd(directories{i});
        files = dir;
        files = files(3:end);
        %files es un struct por lo que lo pasamos a un cell de strings
        before = cd('..');
        filenames = getFileNames(files);
        %ahora lo ordenamos (debe coincidir con el mismo orden de los archivos .mat)
        [sortedFiles, indexes]=sort(filenames);
        cd(before);
        disp(['Archivo: ', sortedFiles{j}]);
         fid=fopen(sortedFiles{j});
            older=cd('..');
            
            %Leemos dentro del archivo y obtenemos la data junto con el
            %periodo de la estrella.
            read = readMACHOFile(fid);
            time = read(:,1);
            data = read(:,2);
            
            %Aplicamos técnicas de análisis de datos para obtener un vector
            %de características (periodo, mediana, IQR, etc) y lo pegamos
            %a la resultado de retorno
            period=periods(j,i);
            disp(['Periodo : ', num2str(period)]);
            [ftime, fdata] = epochFolding(read, period);

subplot(3,1,1);
plot(time,data,'b*');
title([dirname, ' ',sortedFiles{j},' sin epoch Folding']);

subplot(3,1,2);
plot(ftime, fdata,'m*');
title([dirname,' ' ,sortedFiles{j},' con epoch Folding']);

[model, tmodel, outliers] = machoSmooth(fdata,ftime, 60, 0.5);

subplot(3,1,3);
plot(tmodel, model,'r*');
title([dirname,' ',sortedFiles{j}, ' con epoch Folding + suavizado + ',num2str(outliers),' outliers eliminados']);


fclose(fid);
