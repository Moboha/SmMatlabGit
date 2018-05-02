noCSOstructs = 0;
noEvents = 0; 

for i=1:length(Muses)
   for j=1:length(Muses(i).consOut)
      if strcmp( Muses(i).consOut(j).type, 'Weir')
         noCSOstructs = noCSOstructs + 1; 
         tempScores = myBenchmarks(xx, SMtime,  FlowTS, {Muses(i).consOut(j).name}, false);
         noEvents = noEvents + tempScores.CSOstats.Nobs
         
      end
   end
    
    
end