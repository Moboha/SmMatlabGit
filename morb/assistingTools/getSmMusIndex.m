function index = getSmMusIndex( Muses, CompName )
%GETSMMUSINDEX Summary of this function goes here
%   Detailed explanation goes here
index = 0;
for i=1:length(Muses)
    
    if( strcmp(Muses(i).name, CompName))   
       index = i;
       break;
       
    end
    
end
if index == 0
    error('not found')
end


end

