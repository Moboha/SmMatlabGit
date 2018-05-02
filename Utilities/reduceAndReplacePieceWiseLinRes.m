function reduceAndReplacePieceWiseLinRes(conn, model, bPlot, bReplace)
%PLOTPIECEWISELINRESPARAMS Summary of this function goes here
%   Detailed explanation goes here

if(conn.typeTag ~= 'PieceWiseLinRes')
    fprintf('not a PieceWiseLinRes connection');
    conn.typeTag
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
[newXs, newYs ] = reduceNumberOfSegments2(3,Xs, Ys);

j=1;
for i=1:2:(2*length(newXs)) 
newParameterArray(i)= newXs(j);  %#ok<AGROW>
newParameterArray(i+1) = newYs(j);    %#ok<AGROW>
j=j+1;
end

if(bReplace), conn.setParameters(newParameterArray); end

if(bPlot), plot(Xs,Ys,'*b'); 
%   title(strcat('from:',num2str(from), ' to:', num2str(to))); 
  title( strcat('from:',char(model.getNodeName(from)), ' to:', char(model.getNodeName(to)))); 
xlabel('Volume')
ylabel('Discharge')
hold on
plot(newXs,newYs,'-*r')
legend('original','reduced')
end
end

