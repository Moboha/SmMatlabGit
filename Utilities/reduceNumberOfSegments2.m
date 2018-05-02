function [ newXs, newYs ] = reduceNumberOfSegments2( Nsegments, Xs, Ys)
%Nsegments is the number of segments in the area between y=0 and y max. 
%Ekstra points are added when these are not at y=0 and y max. 
%Function does not allow for decreasing y for increasing x.

N = Nsegments + 1;
index1 = 2;%index in newX and Y of first free point

if(Ys(2) ==0) 
    N=N+1; 
    index1 = 3;
end
index2 = N-1;%index of last free point

[m, indexMax] = max(Ys);
if( indexMax ~= length(Ys)) 
    N=N+1;   
end


newXs = zeros(N,1);
newYs = zeros(N,1);
x0 = [newXs; newYs];
lb = zeros(size(x0));
ub = zeros(size(x0));

x0(1) = 0; x0(1+N) = 0;
x0(N) = Xs(end); x0(N+N) = max(Ys);

lb(1) = 0; lb(1+N) =0; ub(1) = 0; ub(1+N) = 0; %set upper and lower bound for x and y for first point to 0.

lb(N) =x0(N); ub(N) = x0(N); lb(N+N) = x0(N+N); ub(N+N) = x0(N+N);%fix largest value for x and y.
if(index2~= N - 1)
    x0(index2+1) = Xs(indexMax);
    x0(index2+1+N) = Ys(indexMax); 
    lb(index2+1) =x0(index2+1); 
    ub(index2+1) = x0(index2+1); 
    lb(index2+1+N) = x0(index2+1+N); 
    ub(index2+1+N) = x0(index2+1+N); 
end


lastXwithZeroY=0;
for i=1:length(Ys)
    if(Ys(i)>0)
        lastXwithZeroY = Xs(i-1);
        break;
    end
end

if(lastXwithZeroY>0)
    lb(2) = lastXwithZeroY; lb(2+N) =0; ub(2) = lastXwithZeroY; ub(2+N) = 0; x0(2)=lastXwithZeroY;
end



nFreePoints = index2-index1+1; %number of free points left (including the last point.
aa = PiecewiseLinearInterpolater([Xs; Ys]);

% creates equidistant points on y an gets approx x and y(x) for initial points
deltaY = max(Ys)/(nFreePoints+1);
for i=index1:index2 
    j=1;
    while Ys(j)<(x0(i - 1 +N) + deltaY )
    j=j+1;
    end
    
    x0(i) = Xs(j-1);   
    x0(i+N) = aa.calcValue(x0(i));
end


%calculate upper and lower bounds for the search. 
for i=index1:index2
    if(i==index1)%the first free index has lowest limit at previous value. 
         lb(i) = x0(i-1);  
         lb(i+N) = x0(N+i-1);
    else %otherways halfway.
         lb(i) = (x0(i-1) + x0(i))/2;  
         lb(i+N) = (x0(N+i-1) + x0(N+i))/2;
    end
    
    if(i==index2)%last free point has upper limit at max. 
        ub(i) = x0(i+1);
        ub(i+N) = x0(i+1+N);
    else
        ub(i) = (x0(i+1) + x0(i))/2;
        ub(i+N) = (x0(i+1+N) + x0(i+1+N))/2;
    end
    
end



%search for optimum.
awrap = wrappedInterpolater([Xs;Ys]);

%plot(lb), hold on, plot(x0), plot(ub)
%[lb, x0, ub]

x= fmincon(@awrap.ssRelE,x0,[],[],[],[],lb, ub);

newXs = x(1:end/2);
newYs = x(end/2+1:end);


ub
x0
lb

end


