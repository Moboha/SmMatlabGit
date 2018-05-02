classdef wrappedInterpolater
    %WRAPPEDINTERPOLATER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Xs
        Ys
        aa %a piecewise interpolater instance
    end
    
    methods
        function obj = wrappedInterpolater(points)
            obj.aa = PiecewiseLinearInterpolater(points);
            obj.Xs = points(1,:);
            obj.Ys = points(2,:);
        end
        
        
        function objf = ssRelE(obj, params)
            %calculate the squred relative difference, where the difference is relative
            %to Xs
            
            
            newXs = params(1:end/2);
            newYs = params(end/2+1:end);          
            bb = PiecewiseLinearInterpolater([newXs, newYs]');
            
            objf = 0;
            for i=2:length(obj.Xs) %to avoid dividing with zero.
              %objf = objf + ((bb.calcValue(obj.Xs(i)) - obj.Ys(i))/obj.Xs(i))^2;
              objf = objf + ((bb.calcValue(obj.Xs(i)) - obj.Ys(i))/1)^2;
            end
            objf = objf * max(obj.Ys);%just an ugly fix to avoid the search to stop prematurely. 
        end
        
    end
    
end

