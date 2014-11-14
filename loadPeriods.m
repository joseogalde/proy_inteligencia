function periods = loadPeriods(maindir)
%makes a .mat file with the period of each star from the MACHO database

    cd(maindir);
    
    periods=[];
    makeCEPHPeriods;
    load('CEPH_periods.mat');
    periods=[periods, ceph.periods];
    
    makeEBPeriods;
    load('EB_periods.mat');
    periods=[periods, eb.periods];
    
    makeRRLPeriods;
    load('RRL_periods.mat');
    periods=[periods, rrl.periods];
end
