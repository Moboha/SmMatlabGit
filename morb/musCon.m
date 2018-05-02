classdef musCon
    %MUSCON Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        type %weir, link, pump
        name
        fromMus
        toMus
                
        outlet
        
        VolQdata
        connectionNo
    end
    
    methods
        function obj = musCon()
            obj.outlet = '';
        end
            
            
            
    end
    
end

