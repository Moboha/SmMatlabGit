function Muses = extrapolateQVs(Muses, factor)
%multiply the last volume in each Mus with factor


for i=1:length(Muses)
   for j=1:length(Muses(i).consOut)
       
       Muses(i).consOut(j).VolQdata(end,1) = factor*Muses(i).consOut(j).VolQdata(end,1);
   end
end


end


