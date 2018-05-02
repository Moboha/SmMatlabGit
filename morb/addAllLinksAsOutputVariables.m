function listOfAllLinks = addAllLinksAsOutputVariables(model, MusesWithCatchments)

outletLinks = {};
interconnections = {};
listOfAllLinks = {};

for i=1:length(MusesWithCatchments)
    for(j=1:length(MusesWithCatchments(i).consOut))
        if(isempty(MusesWithCatchments(i).consOut(j).toMus))
         outletLinks{end+1} = MusesWithCatchments(i).consOut(j).name;
        else
            iTo = MusesWithCatchments(i).consOut(j).toMus;
            interconnections{end+1} = {MusesWithCatchments(i).name, MusesWithCatchments(iTo).name,   MusesWithCatchments(i).consOut(j).name};  
        end
    end
end


for i=1:length(outletLinks)
model.addOutputVariable(blank2brack(outletLinks{i}));
listOfAllLinks{end+1} = outletLinks{i};
end
%************************
for i=1:length(interconnections)
model.addOutputVariable(interconnections{i}{1},interconnections{i}{2},interconnections{i}{3});
listOfAllLinks{end+1} = interconnections{i}{3};
end

end