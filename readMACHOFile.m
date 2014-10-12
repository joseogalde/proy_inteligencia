function [readData, period] = readMACHOFile(fid, dirname)
    %Lee una serie de tiempo de un MACHO representada por el descriptor de
    %archivos 'fid'.
    
    %% Lectura del periodo, pura fuerza bruta, no es necesario mirar
    if  strcmp(dirname,'EB')
        lines=4;
        formatPeriod='%s %s %f';
        delPeriod=' ';
        pos=3;
    else%if strcmp(dirname,'CEPH') || strcmp(dirname, 'RRL')
        lines = 2;
        formatPeriod='%s %f %s';
        delPeriod=' ';
        pos=2;
    end
    %Sacamos los primos N strings del archivo y nos quedamos con el que
    %contiene la linea donde indica el periodo del MACHO
    header = textscan(fid,'%s',lines, 'delimiter', '\n');
    strPeriod = header{1}{lines}; %osea, este string
    %Leemos dicho string y sacamos el valor del periodo
    strScan = textscan(strPeriod,formatPeriod, 'delimiter', delPeriod, 'MultipleDelimsAsOne',1);
    period=strScan{pos};
    
    %% Conversion de las series de tiempo a datos
    formatData = '%f %f %f';
    cell_data = textscan(fid, formatData,'CommentStyle', '#');
    readData= cell2mat(cell_data);
end