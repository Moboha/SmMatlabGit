function testReduceAndReplace
originalModel = 'R:\Research Communities\SurrogateModelling\Matlab\InGit2\Utilities\tests\TestData\TrojBas1.PRM';
reducedModel = 'R:\Research Communities\SurrogateModelling\Matlab\InGit2\Utilities\tests\TestData\reducedModel.prm';

%originalModel = 'H:\SyncPC\csharp\SurrogateModels\DtuSmModels\TestData\trojBas2_maxvol.PRM'
%reducedModel = 'H:\SyncPC\csharp\SurrogateModels\DtuSmModels\TestData\output\trojBas2_maxvol_red.PRM'

if exist(reducedModel, 'file')==2
  delete(reducedModel);
end
n_item = 26;


model = DtuSmModels.MainModel();
model.initializeFromFile(originalModel);
conns = model.getConnections;
reduceAndReplacePieceWiseLinRes(conns.Item(n_item), model, true, true)
model.saveModelParameters(reducedModel);
model.releaseOutFile();
delete(model);

figure

model = DtuSmModels.MainModel();
model.initializeFromFile(reducedModel);
conns = model.getConnections;
plotPieceWiseLinResParams(conns.Item(n_item), model)
title('saved and re-read reduced model');
model.releaseOutFile();
delete(model);

end