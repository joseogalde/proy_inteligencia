function data=loadMACHO(maindir)
    %Funcion que abre la base de datos y guarda los datos de los archivos
    %en un cell-array de cada carpeta.
    % 'data' es una matriz de vectores columnas. Cada vector corresponde a
    % una serie de tiempo
    
    %Creamos un arreglo con los directorios de MACHO
    cd(maindir);
    files = dir;
    directories = [];
    
    for i=1:length(files)
        if files(i).isdir && ( strcmp(files(i).name,'CEPH') || strcmp(files(i).name,'EB') || strcmp(files(i).name,'RRL') )
            directories = [directories; files(i)];
        end
    end

    %Cada columna de 'data' corresponde a uno de los directorios
    data=cell(1,length(directories));
    
    for i=1:length(directories)
    
        %Nos movemos a una de las carpetas CEPH, EB o RRL y vamos abriendo
        %cada uno de los archivos dentro de ellas
        cd(directories(i).name);
        files = dir;
        files = files(3:end);
        
        for j=1:length(files)
        
            fid=fopen(files(j).name);
            older=cd('..');
            
            %Leemos dentro del archivo y obtenemos la data junto con el
            %periodo de la estrella.
            [read_data, period]=readMACHOFile(fid, directories(i).name);
            
            %Aplicamos técnicas de análisis de datos para obtener un vector
            %de características (periodo, mediana, IQR, etc) y lo pegamos
            %a la resultado de retorno
            folded = epochFolding(read_data, period);
            x = extractInfo(folded);
            data{i}=[data{i} x];
            
            fclose(fid);
            cd(older);
        end
        cd('..');
    end

end
    