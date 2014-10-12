function data=loadMACHO(maindir)
    %Funcion que abre la base de datos y guarda los datos de los archivos
    %en un cell-array de cada carpeta.
    
    %Abrimos la carpeta con los datos y listamos los archivos
    cd(maindir);
    files = dir;
    directories = [];
    
    %Obtenemos un arreglo con los directorios
    for i=1:length(files)
        if files(i).isdir && ( strcmp(files(i).name,'CEPH') || strcmp(files(i).name,'EB') || strcmp(files(i).name,'RRL') )
            directories = [directories; files(i)];
        end
    end

    %Cada columna de 'data' corresponde a uno de los directorios
    data=cell(1,length(directories));
    
    %Buscamos en las carpetas de la base de datos
    for i=1:length(directories)
    
        %Nos movemos a una de las carpetas CEPH, EB o RRL
        cd(directories(i).name);
        files = dir;
        files = files(3:end);
        
        %Abrimos c/u de los archivos de la carpeta
        for j=1:length(files)
        
            fid = fopen(files(j).name);
            %Lee el archivo y retorna y cell-array con los datos
            scan = textscan(fid, '%f %f %f','CommentStyle','#');
            %Pasamos el cell-array a una matiz de 'double'
            matrix_data=cell2mat(scan);
            %bug: hay que volver a la carpeta donde se encuentra el archivo
            %fuente de extractInfo
            cd('..');
            
            %lee la matriz y extrae parámetros que definen la curva de luz
            x=extractInfo(matrix_data);
            data{i}=[data{i} x];
            
            %Cerramos el archivo y volvemos al directorio
            fclose(fid);
            cd(directories(i).name);
        end
        cd('..');
    end

end
    