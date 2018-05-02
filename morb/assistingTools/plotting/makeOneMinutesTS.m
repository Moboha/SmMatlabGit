function TSout = makeOneMinutesTS( TS, firstMinuteAsDatenum, LastMinuteAsDateNum )
%TS is a time series array [datenum, double]
Nsteps = 1+ round((LastMinuteAsDateNum - firstMinuteAsDatenum)*24*60);
%datestr(firstMinuteAsDatenum)
%datestr(TS.time(1))
%datestr(LastMinuteAsDateNum)

TSout.data = zeros(Nsteps,1);
TSout.time = zeros(Nsteps,1);

j=1;
ti=1;

if( (TS.time(1) - firstMinuteAsDatenum) > 1/(24*60))
    error('start time is before first data point in ts. ');
end

while TS.time(j) < (firstMinuteAsDatenum + (ti-1-0.4)/(24*60) )
    j=j+1;
end


ti = 1;
while ti < Nsteps+1
    
    while TS.time(j) > (firstMinuteAsDatenum + (ti-1+0.5)/(24*60) )
    TSout.data(ti)= 0;
    TSout.time(ti) = firstMinuteAsDatenum + (ti-1)/(24*60);
        
        ti=ti+1;
    end

    TSout.data(ti)= TS.data(j);
    TSout.time(ti) = firstMinuteAsDatenum + (ti-1)/(24*60);
    
    j=j+1;
    ti=ti+1;
end

