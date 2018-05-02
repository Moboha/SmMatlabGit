MusesWithMPCinput = extractMusInforFromFolder('C:\affald\Aarhus\MPC\MPCsubmodelinputs');
listOfMPCinput = listAllLinksInMuses(MusesWithMPCinput);

scoresx = myBenchmarks(xx, SMtime,  FlowTS, listOfMPCinput, false);

[NSEs, NSE30s, relSumEs] =   scores2lists( scoresx );
figure; plot(NSE30s)
figure; plot(relSumEs)
%myBenchmarks(xx, SMtime,  FlowTS, {'Link_673'}, true);



i=1;
scoreMPC1 = myBenchmarks_aggregatingFlows(xx, SMtime,  FlowTS, MusesWithMPCinput(i).links, true)
title(MusesWithMPCinput(i).name)

i=2;
scoreMPC1 = myBenchmarks_aggregatingFlows(xx, SMtime,  FlowTS, MusesWithMPCinput(i).links, true)
title(MusesWithMPCinput(i).name)

i=3;
scoreMPC1 = myBenchmarks_aggregatingFlows(xx, SMtime,  FlowTS, MusesWithMPCinput(i).links, true)
title(MusesWithMPCinput(i).name)

i=4;
scoreMPC1 = myBenchmarks_aggregatingFlows(xx, SMtime,  FlowTS, MusesWithMPCinput(i).links, true)
title(MusesWithMPCinput(i).name)

i=5;
scoreMPC1 = myBenchmarks_aggregatingFlows(xx, SMtime,  FlowTS, MusesWithMPCinput(i).links, true)
title(MusesWithMPCinput(i).name)

i=6;
scoreMPC1 = myBenchmarks_aggregatingFlows(xx, SMtime,  FlowTS, MusesWithMPCinput(i).links, true)
title(MusesWithMPCinput(i).name)