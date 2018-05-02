MusesWithMPCinput = extractMusInforFromFolder('C:\affald\Aarhus\MPC\MPCsubmodelinputs');
listOfMPCinput = listAllLinksInMuses(MusesWithMPCinput);
scoresx = myBenchmarks(xx, SMtime,  FlowTS, listOfMPCinput, false);
[NSE, NSE30, relSumErr, lags, absSumErr] =   scores2lists( scoresx );
vols = absSumErr./relSumErr;
sum(vols.*NSE30)/sum(vols)

close all

[~, ind] = sort(-vols)

figure
yyaxis left;
%bar(vols,'FaceColor',[0 .5 .5],'EdgeColor',[0 .1 .1],'LineWidth',3.5)
bar(vols(ind),'FaceColor', [0.9 .9 .9]);
ylabel('Accumulated discharge [m3]')
hold on

yyaxis right; 
%bar(NSE30)
plot(NSE30(ind),'*r')

xlim([0 32])
ylabel('NSE30 / relVol [-]')
xlabel('MPC Input no')

plot(relSumErr(ind)+1,'*b')
legend('runoff volume', 'NSE30' ,'relVol') 
title('Surrogate Model Performance')




