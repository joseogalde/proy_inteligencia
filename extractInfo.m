function y =extractInfo(matrix_data)
    
    %aplicar epoch floding
    folded_data=epochFolding(matrix_data);
    
    y=[];
    for i=1:3
        % y = [tiempo, promedio, desv_std] ?
        y=[y ;mean(folded_data(:,i))];
    end
end