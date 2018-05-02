

PRMfile = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\frri\Zones_1_2\PRMout8_b.prm';

model = DtuSmModels.MainModel(); %instantiate model
SmParameterFile = PRMfile
model.initializeFromFile(SmParameterFile);
conns = model.getConnections;
model.addOutputVariable('sm4bas','sm4','fromBas');
model.addOutputVariable('sm4','sm4bas','toBas');

model.setRainDataForAllCatchments(rain);
model.runForOneMinuteRainInput()

xx = model.output.dataCollection.ToArray;
tt = model.output.timeInSeconds.ToArray;
sv = model.state.values.double;
resx1 = xx(1);
resx2 = xx(2);

values1 = resx1.data.ToArray.double;
values2 = resx2.data.ToArray.double;
figure

plot(tt.double/3600, values1 ); 
hold on;
plot(tt.double/3600, values2 ); 

sum(values1*60)
sum(values2*60)
sum((values1-values2)*60)

