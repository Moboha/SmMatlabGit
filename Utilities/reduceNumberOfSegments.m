function [ newXs, newYs ] = reduceNumberOfSegments( Nsegments, Xs, Ys, optionalx0X )
%The result will always start in 0,0 and end at the largest existing x
%value and with the highest y value present in the initial data points.




if(nargin > 3)
    N = length(optionalx0X);
else
    N = Nsegments + 1;
end
newXs = zeros(N,1);
newYs = zeros(N,1);

newXs(1) = 0; newYs(1) = 0;
newXs(end) = Xs(end); newYs(end) = Ys(end);% make this optional
x0 = [newXs; newYs];
lb = zeros(size(x0));
ub = zeros(size(x0));

j=1;
lb(j) = 0; lb(j+N) =0; ub(j) = 0; ub(j+N) = 0; %set upper and lower bound for x and y for first point to 0.
j=j+1;


lastXwithZeroY=0;
for i=1:length(Ys)
    if(Ys(i)>0)
        lastXwithZeroY = Xs(i-1);
        break;
    end
end

if(lastXwithZeroY>0)
    lb(j) = lastXwithZeroY; lb(j+N) =0; ub(j) = lastXwithZeroY; ub(j+N) = 0; x0(j)=lastXwithZeroY;
    j=j+1;
end

nleft = N - j + 1; %number of free points left (including the last point.
deltaX =  (Xs(end)-lastXwithZeroY)/nleft;

points = [Xs; Ys]; aa = PiecewiseLinearInterpolater(points);

for i=j:N-1 % creates equidistant points on x an gets y from initial points
    if(nargin > 3)
        x0(i) = optionalx0X(i);
    else
        x0(i) = x0(i-1) + deltaX;
    end
    
    x0(i+N) = aa.calcValue(x0(i));
end
i=i+1;
x0(i) = Xs(end); x0(i+N) =  max(Ys);

%f1 = 0.2 means the search interval is goes to 20% towards the next param value.
if(nargin > 3)
    f1=0.1; 
else
    f1=0.5;
end
f2 = 1-f1; % 

for j=j:N-1 % the search interval set to midway between values.
    lb(j) = x0(j-1) * f1 +x0(j)* f2;
    ub(j) = f2*x0(j)+x0(j+1)*f1;
   
    lb(j+N) = x0(N+j-1)*f1+x0(N+j)*f2;
    ub(j+N) = x0(N+j)*f2+x0(N+j+1)*f1;
end
lb(N) = Xs(end);ub(N) = Xs(end); %fix largest value for x and y.
lb(N+N) = max(Ys);ub(N+N) = max(Ys);


awrap = wrappedInterpolater([Xs;Ys]);
x= fmincon(@awrap.ssRelE,x0,[],[],[],[],lb, ub);

newXs = x(1:end/2);
newYs = x(end/2+1:end);


end


