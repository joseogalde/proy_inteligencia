function sigma= stdSilverman(data, dimension)
% Calcula la desviacion std propuesta por Silverman para GP
    sum=0;
    for i=1:dimension
        sum= sum + std(data(i,:))^2;        
    end
   
    sigma2_x=sum/dimension;
    N=size(data,2);
    
    sigma=sqrt(sigma2_x)*((4/(N*(2*dimension+1)))^(1/(dimension+4)));
end