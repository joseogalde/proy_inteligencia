function y = desordenarMACHO(database)

    data=database.data;
    target=database.target;
    
    new_order=randperm(length(data));
    
    for k=1:length(new_order)-1
        pos1=new_order(k);
        pos2=new_order(k+1);
        tmp1=data(pos1);
        data(pos1)=data(pos2);
        data(pos2)=tmp1;
        tmp2=target(pos1);
        target(pos1)=target(pos2);
        target(pos2)=tmp2;
    end
    database.data=data;
    database.target=target;
    
    y=database;
end