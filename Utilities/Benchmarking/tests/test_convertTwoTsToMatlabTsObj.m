function test_convertTwoTsToMatlabTsObj
%make two partially overlapping [datenum, double] arrays whith different
%time steps. Convert to matlab ts objects resambled to use the same time
%step. 

tstart = datenum(2010,7,30,15,57,23);


Ts1 = zeros(600, 2);
Ts2 = zeros(100, 2);





for i=1:length(Ts1(:,2))
Ts1(i,1) = tstart + 5*i/(24*60);
Ts1(i,2) = hour(Ts1(i,1));

end

for i=1:length(Ts2(:,2))
    Ts2(i,1) = tstart + 2/24 + 2.5*i/(24*60);
Ts2(i,2) = hour(Ts2(i,1)) + minute(Ts2(i,1))/60;
end
clf
plot(Ts1(:,1), Ts1(:,2))
hold on
plot(Ts2(:,1), Ts2(:,2),'*')

tstart = Ts1(10,1);
tend = Ts2(end-10,1);


tsnew = convertTwoTsToMatlabTsObj(Ts1, Ts2, 1/(24*60));
figure
plot(tsnew)

end