function makeRRLPeriods

% original=cd('./RRL');
% 
% directory = dir;
% directory = directory(3:end);
% 
% before = cd('..');
% filenames = getFileNames(directory);
% 
% cd(before);
% [sortFiles, indexes] = sort(filenames);
% 
% len = length(sortFiles);
% period = [];
%     for j=1:len
%        fid = fopen(sortFiles{j});
%        line = fgetl(fid);
%        line = fgetl(fid);   %periodo esta en la segunda linea
%        scan = textscan(line, '%s %f %s');
%        period = [period; scan{2}];    %periodo 
%        fclose(fid);
%     end
% rrl.names = sortFiles;    
% rrl.periods = period;
% cd(original);
% 
% save RRL_periods.mat rrl

fileID = fopen('RRL_periods.txt');
scan = textscan(fileID,'%s %f');
fclose(fileID);

nombres = scan{1};
valores = scan{2};
[sNombres, indexes] = sort(nombres);

periods = valores(indexes);
rrl.names = sNombres;
rrl.periods = periods;

save 'RRL_periods.mat' rrl

end