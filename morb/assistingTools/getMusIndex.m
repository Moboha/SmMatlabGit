function iMus = getMusIndex( Muses, MusName )

for i=1:length(Muses)
    if(strcmp(Muses(i).name, MusName));
        iMus = i;
        break;
    end
end


end