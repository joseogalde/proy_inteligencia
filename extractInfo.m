function y =extractInfo(data)
% Calcula la media, desv_std, mediana, skewnes, IQR y kurtosis de la
% magnitud de la curva de luz y del error de medicion.

    %La columna 2 y 3 de 'data' corresponden a magnitud y error
    %respectivamente
    N=6;
    y=zeros(2*N,1);
    for j=2:3
        for i=1:N
            k=i*(j-1);
            switch i
                case 1
                    y(k)= mean(data(:,j));
                case 2
                    y(k)=std(data(:,j));
                case 3
                    y(k)=median(data(:,j));
                case 4
                    y(k)= iqr(data(:,j));
                case 5
                    y(k)=skewness(data(:,j));
                case 6
                    y(k)=kurtosis(data(:,j));
            end
        end
    end
end