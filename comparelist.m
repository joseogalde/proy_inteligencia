function rc = comparelist

%%Script que verifica si los periodos de los archivos .mat están ordenados
%%en el mismo orden en el que se leyeron los archivos de los directorios
%%CEPH, EB y RRL

clear all;
close all;

makeDirFileSystem;
load('dirFileSystem.mat');
makeDirPeriodFile;
load('dirPeriodFile.mat');

ceph_cmp = zeros(length(dirFileSystem.ceph),1);
for i=1:length(dirFileSystem.ceph)
    ceph_cmp(i) = strcmp(dirFileSystem.ceph{i},dirPeriodFile.ceph{i});
end

eb_cmp = zeros(length(dirFileSystem.eb),1);
for i=1:length(dirFileSystem.eb)
    eb_cmp(i) = strcmp(dirFileSystem.eb{i},dirPeriodFile.eb{i});
end

rrl_cmp = zeros(length(dirFileSystem.rrl),1);
for i=1:length(dirFileSystem.rrl)
    rrl_cmp(i) = strcmp(dirFileSystem.rrl{i},dirPeriodFile.rrl{i});
end

cmplist.ceph = ceph_cmp;
cmplist.eb = eb_cmp;
cmplist.rrl = rrl_cmp;
save 'cmplist.mat' cmplist

%si cmplist es una matriz de puros 1 estamos bien. Si no hay que verificar
%el orden en que se estan leyendo los archivos

if sum(cmplist.ceph==0)==0 && sum(cmplist.eb==0)==0 ...
        && sum(cmplist.rrl==0)==0
    rc = 0; %todo OK
else
    rc = 1;
end
end