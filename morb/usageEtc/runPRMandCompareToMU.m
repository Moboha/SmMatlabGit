


%Dll ='H:\SyncPC\MBdata\Projekter\KlimaSpring\TechnicalDevelopment\TilAKF\Release\DtuSmModels.dll';
%NET.addAssembly(Dll);

load rainfall1;
rain = rainfall1/1000*60; % convert to mm/min


model = DtuSmModels.MainModel(); %instantiate model
SmParameterFile = strcat(pwd,'\testData\PRMout4.PRM');
model.initializeFromFile(SmParameterFile);

outletLinks = {};
for i=1:length(MusesWithCatchments)
    for(j=1:length(MusesWithCatchments(i).consOut))
         outletLinks{end+1} = MusesWithCatchments(i).consOut(j).name;
    end
end


for i=1:length(outletLinks)
model.addOutputVariable(outletLinks{i});
end

model.setRainDataForAllCatchments(rain);
model.runForOneMinuteRainInput()


