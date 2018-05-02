function testReduceEntireModel
originalModel = 'R:\Research Communities\SurrogateModelling\Matlab\InGit2\Utilities\tests\TestData\TrojBas1.PRM';
cleanModel= 'R:\Research Communities\SurrogateModelling\Matlab\InGit2\Utilities\tests\TestData\trojBas2_maxvol_clean.PRM'
reducedModel = 'R:\Research Communities\SurrogateModelling\Matlab\InGit2\Utilities\tests\TestData\reducedModel.prm';

%originalModel = 'H:\SyncPC\csharp\SurrogateModels\DtuSmModels\TestData\trojBas2_maxvol_v2.PRM'
%cleanModel= 'H:\SyncPC\csharp\SurrogateModels\DtuSmModels\TestData\output\trojBas2_maxvol_clean.PRM'
%reducedModel = 'H:\SyncPC\csharp\SurrogateModels\DtuSmModels\TestData\output\trojBas2_maxvol_red.PRM'

CleanUpPrmFile(originalModel,cleanModel); 

if exist(reducedModel, 'file')==2
  delete(reducedModel);
end

%reduceEntireModel(originalModel, reducedModel);
reduceEntireModel(cleanModel, reducedModel);


end