function succes = testReduceNumberOf(  )
%TESTREDUCENUMBEROF Summary of this function goes here
%   Detailed explanation goes here

succes = 0;

% Xs = [0:24];
% Ys = [0 0 0 1 3 5 6 7 8 10 13 13 15 12 12 14 16 14 18 20 21 20 20 20 20];

 load('R:\Research Communities\SurrogateModelling\Matlab\InGit2\Utilities\tests\TestData\TrappOutlet_results.mat')
 Xs=Volsort(:,1)';
 Ys=Qsort(:,1)';
 Xs=[0 Xs];
 Ys=[0 Ys];


figure();
plot(Xs, Ys, 'b*')
hold on


[newXs, newYs ] = reduceNumberOfSegments2(1,Xs, Ys);
plot(newXs, newYs,'-b');

[newXs, newYs ] = reduceNumberOfSegments2(2,Xs, Ys);
plot(newXs, newYs,'*-r');

[newXs, newYs ] = reduceNumberOfSegments2(3,Xs, Ys);
plot(newXs, newYs,'*-g');


%[newXs, newYs ] = reduceNumberOfSegments2(2,Xs, Ys);
%&plot(newXs, newYs,'-k');

%[newXs, newYs ] = reduceNumberOfSegments(5,Xs, Ys, [0 3 20 24]);
%plot(newXs, newYs,'*-k');

%[newXs, newYs ] = reduceNumberOfSegments(4,Xs, Ys);
%plot(newXs, newYs,'*-k');

%[newXs, newYs ] = reduceNumberOfSegments(5,Xs, Ys);
%plot(newXs, newYs,'-r');

%[newXs, newYs ] = reduceNumberOfSegments(7,Xs, Ys);
%plot(newXs, newYs,'*-g');

end

