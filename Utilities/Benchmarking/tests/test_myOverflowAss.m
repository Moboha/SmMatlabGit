function test_myOverflowAss( )
%TEST_MYOVERFLOWASS Summary of this function goes here
%   Detailed explanation goes here

MUwq =  [0 0 0 3 0 0 0 0 5 6 7 0 0 0];
SMwq1 = [0 0 0 3 0 0 0 0 5 6 7 0 0 0];%identical
SMwq2 = [0 1 0 0 0 0 0 0 1 2 1 0 0 0];% overlaping events if eventSeperater>2 only


observed = MUwq; modelled = SMwq1;eventSep = 3;
CSOstats = myOverflowAss( observed, modelled, eventSep );

assert(CSOstats.Nobs == 2);
assert(CSOstats.Nmod == 2);
assert(CSOstats.Npredicted == 2);
assert(CSOstats.NfalseAlarms == 0);

observed = MUwq; modelled = SMwq2;eventSep = 3;
CSOstats = myOverflowAss( observed, modelled, eventSep );
assert(CSOstats.Nobs == 2);
assert(CSOstats.Nmod == 2);
assert(CSOstats.Npredicted == 2);
assert(CSOstats.NfalseAlarms == 0);

observed = MUwq; modelled = SMwq2;eventSep = 2;
CSOstats = myOverflowAss( observed, modelled, eventSep );
assert(CSOstats.Nobs == 2);
assert(CSOstats.Nmod == 2);
assert(CSOstats.Npredicted == 1);
assert(CSOstats.NfalseAlarms == 1);


end

