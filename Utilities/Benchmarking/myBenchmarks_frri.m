function scores = myBenchmarks(xx, SMtime,  FlowTS, listOfLinks, bPlot)

listOfOutputsFromSM = {};
for i=1:xx.Length
    listOfOutputsFromSM{end+1} = brack2blank(char(xx(i).name));
end

for k=1:length(listOfLinks)
    linkName = listOfLinks{k};
    if strcmp(linkName(end-3:end), '(BW)')
        continue
    end
    
  
    scores(k).name = linkName;
    i = getnameidx(listOfOutputsFromSM, linkName);
    resx = xx(i);   
    values = resx.data.ToArray.double;
    
    %substract backwater flow if exists
    i = getnameidx(listOfOutputsFromSM, [linkName, '(BW)']);
    if(i>0)
    resx = xx(i);   
    valuesBw = resx.data.ToArray.double;
    values = values - valuesBw;
    end
  
      iMU = getnameidx(FlowTS.nameList, linkName);  
      MUresults = [FlowTS.time, FlowTS.data(:,iMU)];
      SMresults = [SMtime; values]';%sm model time is in seconds from start
      tsComb = convertTwoTsToMatlabTsObj(MUresults, SMresults ,60);
%tsComb is a syncronized matlab time series object with MUresults in first data column
%and SM results in the other. 

     if(bPlot) 
         figure
         plot(tsComb); 
         legend('MU','SM');
         ylabel('Q [m3/s]');
         title(linkName);
     end;
      
    %**********data now ready for comparison
    MUdata = tsComb.data(:,1);
    SMdata= tsComb.data(:,2);
    
    
    scores(k).NSE = myNSE(MUdata, SMdata );
    scores(k).NSE30min =  myNSE( myMA(MUdata, 30), myMA(SMdata,30) );
    
    scores(k).RMSE = myRMSE(MUdata, SMdata);
    [relSumErr, AbsSumErr] = relDifInSums(MUdata, SMdata);
    scores(k).relSumErr =relSumErr;
    scores(k).absSumErr = AbsSumErr*60;%converts to m3

    scores(k).CSOstats = myOverflowAss( MUdata, SMdata, 60 );%eventdefinition of 60 minutes

    scores(k).lag = myDisplacement(MUdata, SMdata);
    
end

end

