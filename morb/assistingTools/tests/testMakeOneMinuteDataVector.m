function testMakeOneMinuteDataVector(  )
%TESTMAKEONEMINUTEDATAVECTOR Summary of this function goes here
%   Detailed explanation goes here
filename = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\Rain and csos\kloevShort.txt';
tic
TS = readDataFromDfsTxtFile(filename); %
toc

assert( abs(sum(TS.data) - 486.4150) < 0.01);

oneminutedata = makeOneMinutesTS(TS, datenum([2006,1,1,7,45,0]),datenum([2006,2,1,9,24,0]));
assert( abs(sum(oneminutedata.data) - 486.4150)<0.01)

oneminutedata = makeOneMinutesTS(TS, datenum([2006,1,1,23,23,0]),datenum([2006,1,2,11,29,0]));
assert( abs(sum(oneminutedata.data) - 3.596)<0.01)


end

