%% Crea el archivo .mat con la base de datos

%Cambiar por carpeta donde se descomprimio MACHO.zip
maindir = '/home/jose/UNIVERSIDAD/EL4106/proyectoGP';
macho = loadMACHO(maindir);

macho= desordenarMACHO(macho);

save 'baseMACHO.mat' macho