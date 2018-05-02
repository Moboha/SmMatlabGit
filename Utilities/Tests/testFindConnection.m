function testFindConnection
NET.addAssembly('H:\SyncPC\csharp\SurrogateModels\DtuSmModels\DtuSmModels\bin\Release\DtuSmModels.dll');
            
   
load rainfall1;
rain = rainfall1/1000*60; % convert to mm/min

model = DtuSmModels.MainModel();
model.initializeFromFile('R:\Research Communities\SurrogateModelling\Matlab\InGit2\Utilities\tests\TestData\trojBas1.PRM');
model.setRainDataForAllCatchments(rain);


connectionIndexs = [];
[con, index] = findConnection(model, 'SM3','SM5');
connectionIndexs = [connectionIndexs, index];

disp(['connection between: ', char(model.getNodeName(con.from)), ' and ', char(model.getNodeName(con.to))])


[con, index] = findConnection(model, 'SM24','SM23');
connectionIndexs = [connectionIndexs, index];

savedValues = [];

conns = model.getConnections();
%model.runForOneMinuteRainInput();

for(i=1:400)
model.stepModelWithSetRain(1);
newDataPoints = [conns.Item(connectionIndexs(1)).getFlow, conns.Item(connectionIndexs(2)).getFlow];
savedValues = [savedValues; newDataPoints];
end
    
model.releaseOutFile();
delete(model);

figure();
plot(savedValues)
legend('flow from SM3', 'flow from SM24')



end

