function output = epochFolding(data, period)

    if size(data,2) < 3
       disp('Error en la lectura de la base de datos'); 
       exit;
    end
    
    time= data(:,1);
    mag = data(:,2);
    err = data(:,3);
    len = length(time);
    
    %Calculamos el tamaño de la ventana de tiempo hay entre cada periodo
    for i=1:len
       if time(i) > time(1)+period
           fold_window=i-1;
           break
       end
    end
    
    time=mod(time,period)./period;    
    
    time_fold=zeros(len,1);
    data_fold=zeros(len,1);
    err_fold=zeros(len,1);
    
    k=1;
    ini=1;
    for i=1:length(data_fold)
        data_fold(i)=mag(k);
        err_fold(i)=err(k);
        time_fold(i)=time(k);
        tmp=k+fold_window;
        if tmp <= length(data_fold)
            k=tmp;
        else
            ini=ini+1;
            k=ini;
        end
    end
    output=[time_fold, data_fold, err_fold];
end