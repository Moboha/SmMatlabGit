function FlowTs = extractMusOutflows( MusesWithCons, prfAsCsv)
%EXTRACTMUSOUTFLOWS Summary of this function goes here
%   Detailed explanation goes here
disp('extractMusOutflows');
tic

%index = 1

for i=1:length(MusesWithCons)
    
   for j=1:length(MusesWithCons(i).consOut)
   %disp(MusesWithCons(i).consOut(j).name);
       index = MusesWithCons(i).consOut(j).connectionNo;
       listOfLinksOut{index} = MusesWithCons(i).consOut(j).name;
       %index = index + 1;
   end
end

FlowTs = readFlowTSfromFile(prfAsCsv, listOfLinksOut);

toc
end

