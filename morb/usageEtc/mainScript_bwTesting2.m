% Validation period: R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\frri\Dam_surrogate\Validation_new
% Training data: R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\frri\Dam_surrogate\Staircase7
% CDS rains: R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\frri\CDS_rains\CDS_5
% MUSFILES for compartments: R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\frri\Dam_surrogate\musfiles
% MUSFILES for evaluation: R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\frri\Dam_surrogate\Benchmark




clear all

basefolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up';

musFileFolder = [basefolder, '\frri\Dam_surrogate\musfiles'];   
linksVolFile = [basefolder, '\frri\Dam_surrogate\Staircase7\Volume_links.txt'];
nodesVolFile = [basefolder, '\frri\Dam_surrogate\Staircase7\Volume_nodes.txt'];
mexFile = [basefolder, '\frri\Dam_surrogate\Staircase7\NW_Staircase7.mex'];
prfAsCsv = [basefolder, '\frri\Dam_surrogate\Staircase7\fullPrfResults.csv']; 
ValidationPrfAsCsvAsMat =  'C:\affald\Validation\output.mat'; 
 

Muses = extractMusInforFromFolder(musFileFolder);
MusesWithCons = getMusConnections(Muses, mexFile);
   
%writeMusFilesWithCons( MusesWithCons, [basefolder, '\morb\testData'] )

MusesWithCatchments = getConnectedCatchments2(MusesWithCons, mexFile );
    
VolTS = ExtractMusVolumesFromNodesAndLinksVols2(Muses, nodesVolFile, linksVolFile);
qTS = extractMusOutflows(MusesWithCons, prfAsCsv);
 
PRMfile = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\PRMout10b.prm';
stepsToUse = [5, 8, 12, 16, 19, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96];        % This is need when we will use the staircase rain, to select steady state points

plot(qTS.data(:,1))        % Plot all the data from the top to the end, first column)
hold on                              % To plot on the same graph
plot(stepsToUse, qTS.data(stepsToUse,1), '*r')      % Plot only the time steps defined

hold off

MusesWithSSdata = addSsVolQdataToConnections(MusesWithCatchments, VolTS, qTS, stepsToUse);

%By now MusesWithSSdata contains all relevant info from SS staircase rain. 


%**************add backwater
 CdsLinksVolFile = [basefolder, '\frri\CDS_rains\CDS_5\Volume_links.txt'];
 CdsNodesVolFile = [basefolder, '\frri\CDS_rains\CDS_5\Volume_nodes.txt'];
 CdsPrfAsCsv = [basefolder, '\frri\CDS_rains\CDS_5\output.csv'];%for backwater estimation a.o.
 listOfLinksWithBW = {'93_371302l1';};
Muses = addBwToSelectionOfLinks2(MusesWithSSdata, CdsLinksVolFile, CdsNodesVolFile, CdsPrfAsCsv, listOfLinksWithBW,50);
%***************************
Muses = extrapolateQVs(Muses, 2);
Muses = removeZeroFlowsInMuses(Muses);

%plot V-Q relations

%  [iMus, toMus, iCon] = getConMusIndex( Muses, 'P26330Kw1' )
% vq = Muses(iMus).consOut(iCon).VolQdata; 
% plot(vq(:,1), vq(:,2),'*r'), title(Muses(iMus).consOut(iCon).name)
 %

 
 %


writePRMfile3(Muses,  PRMfile);   %Write the acutal surrogate model
%writePRMfile(MusesWithCatchments, VolTS, qTS, PRMfile, stepsToUse);   %Write the acutal surrogate model

%**************
%try to run the model
%NET.addAssembly('H:\SyncPC\csharp\SurrogateModels\DtuSmModels\DtuSmModels\bin\Release\DtuSmModels.dll');
NET.addAssembly('R:\Research Communities\SurrogateModelling\Bin\Release\DtuSmModels.dll');

%load rainfall1;
filetoload = [basefolder, '\morb\testData\Rain and csos\rain1.mat'];
load(filetoload)
rainfall1 = rain20060811to20060824; %the rain that was just loaded
%datestr(rainfall1.time(1)) %writes start and end time as a check. 
%datestr(rainfall1.time(end))
%plot(rainfall1.time, rainfall1.data);%for inspection.

rain = rainfall1.data/1000*60; % convert to mm/min

model = DtuSmModels.MainModel(); %instantiate model
SmParameterFile = PRMfile;
model.initializeFromFile(SmParameterFile);

% conns = model.getConnections;
% figure
% iCon = MusesWithCons(5).consOut(1).connectionNo - 1;%minus one since c# s zeor based
% plotPieceWiseLinResParams(conns.Item(iCon), model);

listOfAllLinks = addAllLinksAsOutputVariables(model, Muses);

model.setRainDataForAllCatchments(rain(2:end));%displaces one minute in time to account for difference in DHI's data handling and the dll's
model.runForOneMinuteRainInput()

%extract results from SM
xx = model.output.dataCollection.ToArray;
tt = model.output.timeInSeconds.ToArray;
sv = model.state.values.double;
%release model.
%model.releaseOutFile();
%delete(model);

%**********
% reads MU Flow results from mat file created with convertPrfCsvToFlowMatFile.m 
load( ValidationPrfAsCsvAsMat);

%********
%figure;
%plotSingleLink(xx, tt,  FlowTS, '96_OGC200Bl1')
%plotSingleLink(xx, tt,  FlowTS, '93_371302l1')
%figure; plotSingleLink2(xx, tt,  FlowTS, '93_371302l1')


SMtime = tt.double/(24*3600)+ rainfall1.time(1);%converts SM model time to datenum. 
tic
%scores = myBenchmarks(xx, SMtime,  FlowTS, listOfAllLinks, false);
scores = myBenchmarks(xx, SMtime,  FlowTS, {'93_371302l1'}, true);
%MusesWithBw = Muses; plotBwQsBothWays( MusesWithSSdata, MusesWithBw, '93_371302l1' )

toc
scores(1)
scores(1).CSOstats

%figure; plotAllOutletsFromCompartments(xx, tt, FlowTS, MusesWithCons, 'smZ6-11a')


for i=1:length(Muses)
    for j=1:length(Muses(i).consOut)
        if (strcmp(Muses(i).consOut(j).type, 'Pump')),
            disp('pump - check q-vol')
            disp(Muses(i).name)
            i
            j 
        end
    end
end
