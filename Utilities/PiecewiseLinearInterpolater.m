classdef PiecewiseLinearInterpolater
% PiecewiseLinearInterpolater is a class which handles linear functions
% between given data points and identifies vlaues of this.
    
    properties
        slopes              % Slopes of the individual liniear segments.
        intersects          % Intersects with y axis for the liniear segments.
        xStart              % Start of intervals.
        nInt                % Number of defined intervals.
    end
    
    methods
        % Creates piecewise linear function between input points. 
        % points is a [2,:] matrix containing the endpoints of the liniear
        % segments.
        function obj = PiecewiseLinearInterpolater(points)
            obj.nInt = length(points(1,:)) - 1;
            obj.xStart = points(1,:);
            % Defines slopes and intersections
            for i=1:obj.nInt
                if points(2,i+1) - points(2,i) < eps || points(1,i+1) - points(1,i) < eps
                    obj.slopes(i) = 0;
                else
                    obj.slopes(i) = (points(2,i+1) - points(2,i))/(points(1,i+1) - points(1,i));
                end
              obj.intersects(i) = points(2,i) - obj.slopes(i)*points(1,i);
            end
        end
        % Extracts y data in piecewise lienar function by x data point
        function y = calcValue(obj, x)
            for i=1:obj.nInt
                % Calculates y from: y= a * x + b; 
                if(x<obj.xStart(i+1))
                    y = obj.intersects(i) + x*obj.slopes(i);
                    return;
                end
                y = obj.intersects(obj.nInt) + x*obj.slopes(obj.nInt);
            end                 
        end
    end    
end
