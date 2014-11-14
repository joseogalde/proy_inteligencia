function names = getFileNames(directory)

    len = length(directory);
    names = cell(len,1);
    
    for i=1:len
        names{i}=directory(i).name;
    end

end