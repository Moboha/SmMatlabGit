function [Xs, Ys] = plotPieceWiseLinResParams2(conn, model)
%PLOTPIECEWISELINRESPARAMS Summary of this function goes here
%   Detailed explanation goes here

if(conn.typeTag ~= 'PieceWiseLinRes')
    fprintf('not a PieceWiseLinRes connection');
    conn.typeTag
    plot(0,0);
    title('not a PieceWiseLinRes connection');
    return; 
    
end

parameterArray = conn.getParameterArray.double;
from = conn.from; 
to = conn.to;

j=1;
for i=1:2:length(parameterArray) 
Xs(j)=parameterArray(i);
Ys(j)= parameterArray(i+1);
   
j=j+1;
end

plot(Xs,Ys,'*--b')

%   title(strcat('from:',num2str(from), ' to:', num2str(to))); 
  title( strcat('from:',char(model.getNodeName(from)), ' to:', char(model.getNodeName(to)))); 
xlabel('Volume')
ylabel('Discharge')

hold on

%[newXs, newYs ] = reduceNumberOfSegments2(3,Xs, Ys);
%plot(newXs,newYs,'-*r')

end

