function listOfLinkNames = listAllLinksInMuses( Muses )
%lists all links in Muses (not just the ones connecting to other mus'

listOfLinkNames = {};
for i=1:length(Muses)
    
    for j=1:length(Muses(i).links)
        listOfLinkNames{end+1} = Muses(i).links{j};
    end



end

