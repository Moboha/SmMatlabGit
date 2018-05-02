function reduceEntireModel( originalModel, reducedModel)
%create a new model where all piecewiseLinear connections are reduced to N
%segments

model = DtuSmModels.MainModel();
model.initializeFromFile(originalModel);

conns = model.getConnections;
N = conns.Count;
for i=0:N-1
    i
    reduceAndReplacePieceWiseLinRes(conns.Item(i), model, false, true);
end

model.saveModelParameters(reducedModel);

model.releaseOutFile();
delete(model);
end

