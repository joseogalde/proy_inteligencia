function makeDirFileSystem

maindir = '/home/jose/UNIVERSIDAD/EL4106/proyectoGP';
cd(maindir);

before = cd('CEPH');
d = dir;
d = d(3:end);   %'.' y '..' no cuentan
ceph = cell(length(d),1);
for i=1:length(d)
    ceph{i}=strrep(d(i).name,'_blue','');
end
cd(before);

before = cd('EB');
d = dir;
d = d(3:end);%'.' y '..' no cuentan
eb = cell(length(d),1);
for i=1:length(d)
    eb{i} = strrep(d(i).name,'_blue','');
end
cd(before);

before = cd('RRL');
d = dir;
d = d(3:end);   %'.' y '..' no cuentan
rrl = cell(length(d),1);
for i=1:length(d)
    rrl{i}= strrep(d(i).name,'_blue','');
end
cd(before);

dirFileSystem.ceph = ceph;
dirFileSystem.eb = eb;
dirFileSystem.rrl = rrl;
save 'dirFileSystem.mat' dirFileSystem
end