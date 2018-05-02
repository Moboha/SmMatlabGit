%R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\frri\Dam_surrogate\musfiles

clear all
basefolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\frri\Aarhus_surrogate\';

PRMfile = [basefolder, 'Model\toyModel2\myFirstModel.prm'];
musFileFolder = [basefolder, 'Musfiles\affald1'];
mexFile = [basefolder, 'Staircase7\NW_Staircase_7Base.mex'];
linksVolFile = [basefolder, 'Staircase7\Volume_links.txt'];
nodesVolFile = [basefolder, 'Staircase7\Volume_nodes.txt'];
prfAsCsv = [basefolder, 'Staircase7\fullPrfResults.csv'];
 
%ValidationPrfAsCsvAsMat = [basefolder, '\frri\Aarhus_surrogate\Validation_paper_16events\Results_files_mat_format\2014_0109_0112.mat']; 
ValidationPrfAsCsvAsMat = ['R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\frri\Aarhus_surrogate\Validation\output_aarhus_noinitLosses.mat'];

Muses = extractMusInforFromFolder(musFileFolder);
MusesWithCons = getMusConnections(Muses, mexFile);
writeMusFilesWithCons( MusesWithCons, [basefolder, 'Model\toyModel2'] )
MusesWithCatchments = getConnectedCatchments2(MusesWithCons, mexFile );


VolTS = ExtractMusVolumesFromNodesAndLinksVols2(Muses, nodesVolFile, linksVolFile);
qTS = extractMusOutflows(MusesWithCons, prfAsCsv);

% PRMfile = 'C:\Users\morb\Desktop\AarhusSM_to_DHI_02052017.prm';
stepsToUse = [8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 94, 96 ];      
plot(qTS.data(:,:))        % Plot all the data from the top to the end, which column)
hold on                              % To plot on the same graph
plot(stepsToUse, qTS.data(stepsToUse,:), '*r')      % Plot only the time steps defined
hold off

MusesWithSSdata = addSsVolQdataToConnections(MusesWithCatchments, VolTS, qTS, stepsToUse);
%By now MusesWithSSdata contains all relevant info from SS staircase rain. 

Muses = MusesWithSSdata;
Muses = extrapolateQVs(Muses, 5);
Muses = removeZeroFlowsInMuses(Muses);

%************************************
%plot V-Q relations
%************************************
%  [iMus, toMus, iCon] = getConMusIndex( Muses, 'P26320Kl1' )
% vq = Muses(iMus).consOut(iCon).VolQdata; 
% plot(vq(:,1), vq(:,2),'*r'), title(Muses(iMus).consOut(iCon).name)
%************************************

writePRMfile3(Muses,  PRMfile);   %Write the acutal surrogate model

%%
%**************
%try to run the model
%NET.addAssembly('H:\SyncPC\csharp\SurrogateModels\DtuSmModels\DtuSmModels\bin\Release\DtuSmModels.dll');
NET.addAssembly('R:\Research Communities\SurrogateModelling\Bin\Release\DtuSmModels.dll');


filetoload = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\Rain and csos\rain1.mat';
load(filetoload)
rainfall1 = rain20060811to20060824; %the rain that was just loaded
datestr(rainfall1.time(1)) %writes start and end time as a check. 
datestr(rainfall1.time(end))
%plot(rainfall1.time, rainfall1.data);%for inspection.
rain = rainfall1.data/1000*60; % convert to mm/min

model = DtuSmModels.MainModel(); %instantiate model
SmParameterFile = PRMfile;
model.initializeFromFile(SmParameterFile);

listOfAllLinks = addAllLinksAsOutputVariables(model, Muses);

model.setRainDataForAllCatchments(rain);


tic
model.runForOneMinuteRainInput()
toc

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


tStart = rainfall1.time(1);

SMtime = tt.double/(24*3600)+ tStart;%converts SM model time to datenum. 
scores = myBenchmarks(xx, SMtime,  FlowTS, {'Q01540Xl1'}, true);
scores(1)
scores(1).CSOstats
%%
%figure;
%plotAllOutletsFromCompartments(xx, tt, FlowTS, MusesWithCons, 'sm17')

scores = myBenchmarks(xx, SMtime,  FlowTS, listOfAllLinks, true);
%plotAllOutletsFromCompartments(xx, tt, FlowTS, MusesWithCons, 'lille1')
%plotQVolFromMuses(Muses,{'Q22010Kw1'})
plotAllQVolFromMus(Muses(1))


