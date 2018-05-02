classdef singleMUS
    %SINGLEMUS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        links
        nodes
        TAcatchments
        
        consOut
        
    end
    
    methods
        function obj = singleMUS(musFileName)
            SMnamesplit = strsplit(musFileName,'.');          
            obj.name = SMnamesplit{1};
            obj.links = {};
            obj.nodes = {};
            obj.TAcatchments = double.empty(0,2);%array [Imp A, tc]
            
            obj.consOut = musCon.empty; %list of type musCon
            %obj.linkout
        end
        
        function success = isNodeInMus(obj, nodeName)
            success = false;          
            for(k=1:length( obj.nodes ))
                if( strcmp(nodeName,obj.nodes{k}) == 1)
                    %disp(obj.nodes{k})
                    success = true;
                    break;
                end
            end
            
        end
        
        
         function success = isLinkInMus(obj, linkName)
            success = false;          
            for(k=1:length( obj.links ))
                if( strcmp(linkName,obj.links{k}) == 1)
                    %disp(obj.links{k})
                    success = true;
                    break;
                end
            end
            
        end
        
    end
    
end

