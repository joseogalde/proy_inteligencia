function readed = readMACHOFile(fid)  
    %% Conversion de las series de tiempo a datos
    formatData = '%f %f %f';
    cell_data = textscan(fid, formatData,'CommentStyle', '#');
    %ignoramos la 3ra columna de datos
    readed= cell2mat({cell_data{1}, cell_data{2}});
    
end