function p = readPeriod(fid)
    
    %% Lectura de los periodos del descriptor de archivo
    formatData = '%s %f';
    scan = textscan(fid, formatData);
    p= scan{2};

end