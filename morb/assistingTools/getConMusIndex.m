function [fromMus, toMus, iCon] = getConMusIndex( Muses, linkName )

for i=1:length(Muses)
   for j=1:length(Muses(i).consOut)
       if(strcmp(linkName, Muses(i).consOut(j).name))
          fromMus = i;
          toMus = Muses(i).consOut(j).toMus;
          iCon = j;
       end
   end
end


end

