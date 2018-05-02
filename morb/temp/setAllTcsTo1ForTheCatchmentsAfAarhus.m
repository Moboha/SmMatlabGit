function Muses = setAllTcsTo1ForTheCatchmentsAfAarhus(Muses)

    for i=1:length(Muses)
       Muses(i).TAcatchments(:,2)=1;       
    end

end