function [timebins, databins] = partition(time, data, numBins)
    % Las variables de retorno son cell arrays. Cada columna son grupos de
    % datos pertencientes a un bin
    if size(time) ~=size(data)
        exit;
    end

    topEdge = length(time); % define limits
    botEdge = 1; % define limits
    
    binEdges = linspace(botEdge, topEdge, numBins+1);

    i=1:length(time);
    
    [h,whichBin] = histc(i, binEdges);

    timebins=cell(1,numBins);
    databins=cell(1,numBins);
    for i = 1:numBins
        flagBinMembers = (whichBin == i);
        timebins{i}     = time(flagBinMembers);
        databins{i}     = data(flagBinMembers); 
    end
    
    
end