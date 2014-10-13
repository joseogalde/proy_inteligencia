function data=loadMACHO(maindir)
    %Funcion que abre la base de datos y guarda los datos de los archivos
    %en un cell-array de cada carpeta.
    % 'data' es una matriz de vectores columnas. Cada vector corresponde a
    % una serie de tiempo
    
    %Creamos un arreglo con los directorios de MACHO
    cd(maindir);
%     files = dir;
%     directories = [];
%     periodFiles = [];
    
%     for i=1:length(files)
%         if files(i).isdir && ( strcmp(files(i).name,'CEPH') || strcmp(files(i).name,'EB') || strcmp(files(i).name,'RRL') )
%             directories = [directories; files(i)];
%         elseif  strcmp(files(i).name,'CEPH_periods.txt') || strcmp(files(i).name,'EB_periods.txt') || strcmp(files(i).name,'RRL_periods.txt') 
%             periodFiles = [periodFiles; files(i)];
%         end
%     end

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
    
    
    %Cada columna de 'data' corresponde a uno de los directorios
    data=cell(1,length(directories));
    
    for i=1:length(directories)
        
        %Nos movemos a una de las carpetas CEPH, EB o RRL y vamos abriendo
        %cada uno de los archivos dentro de ellas
        cd(directories{i});
        files = dir;
        files = files(3:end);
        
        for j=1:length(files)
        
            fid=fopen(files(j).name);
            older=cd('..');
            
            %Leemos dentro del archivo y obtenemos la data junto con el
            %periodo de la estrella.
            read_data=readMACHOFile(fid);%, directories(i).name);
            
            %Aplicamos técnicas de análisis de datos para obtener un vector
            %de características (periodo, mediana, IQR, etc) y lo pegamos
            %a la resultado de retorno
            folded = epochFolding(read_data, periods(j,i));
            x = extractInfo(folded);
            %Agrego el periodo a las caracteristicas
            x = [periods(j,i); x];
            data{i}=[data{i} x];
            
            fclose(fid);
            cd(older);
        end
        cd('..');
    end

end
    