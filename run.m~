clear all;
close all;
clc;

%Cambiar por carpeta donde se descomprimio MACHO.zip
maindir = '/home/jose/UNIVERSIDAD/EL4106/proyectoGP';
data = loadMACHO(maindir);

%Vectores de caracteristicas para cada caso
ceph=data{1};
eb=data{2};
rrl=data{3};

%dimension de los vectores de caracteristicas
d=size(ceph,1);

%parametros del algoritmo GP
sigma=stdSilverman(ceph, d);
generations= 50;
pop_sz=500;
pcross=0.85;
pmut=0.05;
preprod=0.1;
treedepth=6;
tournament_sz=5;

