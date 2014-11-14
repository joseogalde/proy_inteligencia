function y =extractInfo(time,data, numBins)
% Calcula la media, desv_std, mediana, skewnes, IQR y kurtosis de la
% magnitud de la curva de luz y del error de medicion.

    %La columna 2 y 3 de 'data' corresponden a magnitud y error
    %respectivamente  
    N=6;
    y=zeros(N*numBins,1);
    
    for k=1:numBins
        for i=1:N
            switch i
                case 1
                    y(i+N*(k-1))= mean(data{k});
                case 2
                    y(i+N*(k-1))= std(data{k});
                case 3
                    y(i+N*(k-1))=median(data{k});
                case 4
                    y(i+N*(k-1))= iqr(data{k});
                case 5
                    y(i+N*(k-1))=skewness(data{k});
                case 6
                    y(i+N*(k-1))=kurtosis(data{k});
            end
        end
    end
end