function scores = myBenchmarks_aggregatingFlowsAarhus(xx, SMtime,  FlowTS, listOfLinks, bPlot)

listOfOutputsFromSM = {};
for i=1:xx.Length
    listOfOutputsFromSM{end+1} = brack2blank(char(xx(i).name));
end

for k=1:length(listOfLinks)
    linkName = listOfLinks{k}
    if strcmp(linkName(end-3:end), '(BW)')
        continue
    end
    
  
    
    i = getnameidx(listOfOutputsFromSM, linkName)
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
      if(k==1)
        %MUresults = [FlowTS.time, FlowTS.data(:,iMU)];
        MuTime = FlowTS.time;
        MuFlows = FlowTS.data(:,iMU);
        SmFlows = values';%sm model time is in seconds from start
      else
        MuFlows = MuFlows + FlowTS.data(:,iMU);
        SmFlows = SmFlows + values';
      end

  
end
    MuFlows(MuFlows < 0.032) = 0;


      MUresults = [MuTime, MuFlows];
      SMresults = [SMtime', SmFlows];
      tsComb = convertTwoTsToMatlabTsObj(MUresults, SMresults ,60);
%tsComb is a syncronized matlab time series object with MUresults in first data column
%and SM results in the other. 

    %**********data now ready for comparison
    MUdata = tsComb.data(:,1);
    SMdata= tsComb.data(:,2);
     if(bPlot) 
         figure
         plot(tsComb); 
         legend('MU','SM');
         ylabel('Q [m3/s]');
         title(linkName);
     end;   
    scores.NSE = myNSE(MUdata, SMdata );
    scores.NSE30min =  myNSE( myMA(MUdata, 30), myMA(SMdata,30) );
    
    scores.RMSE = myRMSE(MUdata, SMdata);
    [relSumErr, AbsSumErr] = relDifInSums(MUdata, SMdata);
    scores.relSumErr =relSumErr;
    scores.absSumErr = AbsSumErr*60;%converts to m3

    scores.CSOstats = myOverflowAss( MUdata, SMdata, 60 );%eventdefinition of 60 minutes
end

