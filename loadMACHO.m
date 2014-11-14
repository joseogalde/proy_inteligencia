function database=loadMACHO(maindir)
    %Funcion que abre la base de datos y guarda los datos de los archivos
    %en un cell-array de cada carpeta.
    % 'data' es una matriz de vectores columnas. Cada vector corresponde a
    % una serie de tiempo
    
    cd(maindir);
    %Leemos los archivos .mat que contienen los periodo (ej:CEPH_periods.mat)
    periods = loadPeriods(maindir);
    %Cada columna de 'data' corresponde a uno de los directorios
    directories={'CEPH','EB','RRL'};
    data=cell(1,length(directories));
    
    for i=1:length(directories)
        
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
        
        for j=1:length(sortedFiles)
        
            fid=fopen(sortedFiles{j});
            older=cd('..');
            
            %Leemos dentro del archivo y obtenemos la data junto con el
            %periodo de la estrella.
            read =readMACHOFile(fid);
            
            %Aplicamos técnicas de análisis de datos para obtener un vector
            %de características (periodo, mediana, IQR, etc) y lo pegamos
            %a la resultado de retorno
            [ftime, fdata] = epochFolding(read, periods(j,i));
            
            %Suavizamos las curvas para evitar outliers y ruido
            %fdata = conv(fdata,gausswin(3),'same');
            
            %nbins=4;
            %[tbins, dbins] = partition(ftime, fdata, nbins);
            
            %x = extractInfo(tbins, dbins, nbins);
            %Agrego el periodo a las caracteristicas
            %x = [periods(j,i); x];
            %x = x';
            x=periods(j,i);
            data{i}=[data{i}; x];
            
            fclose(fid);
            cd(older);
        end
        cd('..');
    end
    %etiquetas
     database.data=data{1};
     database.data=[database.data; data{2}];
     database.data=[database.data; data{3}];
     
     database.target=ones(length(data{1}),1);
     database.target=[database.target; 2.*ones(length(data{2}),1)];
     database.target=[database.target; 3.*ones(length(data{3}),1)];
     
     database.name='macho';
end
    