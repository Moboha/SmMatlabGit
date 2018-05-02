function tsMatComb = convertTwoTsToMatlabTsObj(Ts1, Ts2, delta_t_seconds)
    %tsMatComb is a matlab time series object containing data from both Ts1
    %and Ts2 for the period where they overlap.  delta_t is the time between samples in days.

ts1mat = timeseries(Ts1(:,2), (Ts1(:,1)-Ts1(1,1))*24*3600);
ts1mat.TimeInfo.StartDate = Ts1(1,1);
ts1mat.TimeInfo.Units = 'seconds';
ts2mat = timeseries(Ts2(:,2), (Ts2(:,1)-Ts2(1,1))*24*3600);
ts2mat.TimeInfo.StartDate = Ts2(1,1);

[t1,t2]=synchronize(ts1mat,ts2mat,'Uniform','Interval',delta_t_seconds);

tsMatComb = t1;
tsMatComb.data(:,2) = t2.data;

end