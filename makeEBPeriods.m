function makeEBPeriods

fileID = fopen('EB_periods.txt');
scan = textscan(fileID,'%s %f');
fclose(fileID);

nombres = scan{1};
valores = scan{2};
[sNombres, indexes] = sort(nombres);

periods = valores(indexes);
eb.names = sNombres;
eb.periods = periods;

save 'EB_periods.mat' eb
end