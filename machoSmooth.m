function [model, tmodel, outliers] = machoSmooth(foldedData,foldedTime, winsz, beta)

if length(foldedData) ~= length(foldedTime)
   disp('Error: Debe ingrear vectores (datos, tiempo) del mismo tamaño');
   exit; 
end
% Suavizo la curva doblada con un kernel gaussiano
%alpha es el tamaño relativo de la ventana del filtro c/r a la serie de
%tiempo
%winsz=round(alpha*length(foldedData));
filtro = gausswin(winsz);

model  = conv(foldedData,filtro,'valid');
MODEL = mean(model(:));%max(abs(model(:)));
DATA = mean(foldedData(:));%max(abs(foldedData(:)));
model = (DATA/MODEL).*model;

%ajusto las dimensiones de los vectores de la curva a las dimensiones de la
%convolucion
lenvalid = length(model);
lendiff = length(foldedData)-lenvalid;
left = floor(lendiff/2);

if mod(lendiff,2) ==0
    right = left;
else
    right = left+1;
end
%guardo una referencia al valor original de la curva doblada
 originalData = foldedData;
 originalTime = foldedTime;
%modifico la curva (datos, tiempo)
foldedTime = foldedTime(left+1:end);
foldedData = foldedData(left+1:end);
foldedTime = foldedTime(1:(end-right)); 
foldedData = foldedData(1:(end-right)); %ahora model y foldedData/Time tienen las mismas dimensiones

%busco los indices de los outliers. beta es un parametro para determinar
%los outliers
 indexes = abs(foldedData - model) >  beta*std(foldedData); %outliers = excludedata(time,data,'indices',indexes); 
 outliers = sum(indexes);
 originalData(indexes)=[];
 originalTime(indexes)=[];

 model = conv(originalData,filtro,'valid'); 
 lenvalid = length(model);
 lendiff = length(originalData)-lenvalid;
 left = floor(lendiff/2);

if mod(lendiff,2) ==0
    right = left;
else
    right = left+1;
end

tmodel = originalTime(left+1:end);
%originalData = originalData(left+1:end);
tmodel = tmodel(1:(end-right)); 
%originalData = originalData(1:(end-right)); 

%model = sqrt(model.^2 + (hilbert(model)).^2);
%model =  abs(hilbert(model));

model = model./(abs(mean(model(:))));

%ahora los elimino de mi modelo muahahaha


end