function [ftime, fdata] = epochFolding(data, period)
    if size(data,2) < 2
       disp('Error en la lectura de la base de datos'); 
       exit;
    end
    time= data(:,1);
    mag = data(:,2);
    time=mod(time,period)./period;
    
    [ftime, indexes]=sort(time);
    
    fdata = mag(indexes);
end