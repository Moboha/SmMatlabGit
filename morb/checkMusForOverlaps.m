function bOverlaps = checkMusForOverlaps( musesWithCons )

bOverlaps = 0;

nodeoverlaps={};
linkoverlaps= {};

muses = musesWithCons;

for i=1:length(muses)
    
    for j=1:length(muses(i).nodes)
        for (k=1:length(muses))
            if(i~=k)
               if(muses(k).isNodeInMus(muses(i).nodes{j}));
                  nodeoverlaps(end+1) =  muses(i).nodes(j);
                  bOverlaps = true;
               end
            end
        end
    end
    
    for j=1:length(muses(i).links)
        for (k=1:length(muses))
            if(i~=k)
               if(muses(k).isLinkInMus(muses(i).links{j}));
                  linkoverlaps(end+1) =  muses(i).links(j);
                  bOverlaps = true;
               end
            end
        end
    end
             
end
disp('Node overlaps:')
disp(nodeoverlaps(1:end/2))

disp('Link overlaps:')
disp(linkoverlaps(1:end/2))

end

