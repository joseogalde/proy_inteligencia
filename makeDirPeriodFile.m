function makeDirPeriodFile

maindir = '/home/jose/UNIVERSIDAD/EL4106/proyectoGP';
before = cd(maindir);

load('CEPH_periods.mat');
ceph_names = ceph.names;    %es un cell array
for i=1:length(ceph_names)
    ceph_names{i}=strrep(ceph_names{i},'_red','');
end

load('EB_periods.mat');
eb_names = eb.names;    %es un cell array
for i=1:length(eb_names)
    eb_names{i}=strrep(eb_names{i},'_red','');
end

load('RRL_periods.mat');
rrl_names = rrl.names;    %es un cell array
for i=1:length(rrl_names)
    rrl_names{i}=strrep(rrl_names{i},'_red','');
end

dirPeriodFile.ceph = ceph_names;
dirPeriodFile.eb = eb_names;
dirPeriodFile.rrl = rrl_names;
save 'dirPeriodFile.mat' dirPeriodFile

cd(before);
end