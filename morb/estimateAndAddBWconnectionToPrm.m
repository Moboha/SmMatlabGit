function MusesWithBW = estimateAndAddBWconnectionToPrm( MusesWithSSdata,  musFileFolder, CdsNodesVolFile, CdsLinksVolFile, CdsPrfAsCsv )
%Takes a Muses and add a connection back
%These two flows equals out eachother under SS conditions, which should be
%the case in the training data. There two connections have parameters 
%[vol1_1,q1_1+bw_1 ; vol1_2,q1_2+bw_2 ;... and
%[vol2_1,bw_1 ; vol2_2,bw_2;...   where the last is the connection back.  Note that the q's are the same for the comps.
%The vols are known from SS data. The bw's are estimated using compartment
%volume data and flow between compartments. 
%


% First SS estimation. 
% 
% Pw1: Make piecewise interpolater (pw1) with SS
% Pwb: Make pw with SS volume values from downstream comportment that represent the backwards flow Qb.
% Pwf: Make pw with SS volume values from upstream compartment with same SS volume values as in pw1, to represent the extra forward flow Qf, that should exqual out Qb at SS.
% 
% Flow values in Pwf and Pwb are the same, never negative and never drecreasing. 
% N random increasing vectors with q’s are made and put into Pwb and Pwf. Cds volumes and flow are used to calculate and error between estimated using Pw1+Pwf-Pwb as flow values as results of volumes. The best performing of the N’s are added to muses. The forward flow are added to the SS values while the backwards is added as a new connection. 



Muses = MusesWithSSdata;

VolTS = ExtractMusVolumesFromNodesAndLinksVols(Muses, CdsNodesVolFile, CdsLinksVolFile);
qTS = extractMusOutflows(Muses, CdsPrfAsCsv);

%sm5 -> sm6
%get cds flow data between the two compartments.
%Make a dataset with flow back SM6->sm5. 
i = 20; %from sm5 - later perhabs in loop
iCon1 = MusesWithCons(i).consOut(1).connectionNo;
iCon2 = MusesWithCons(Muses(i).consOut(1).toMus).consOut(1).connectionNo;

vq1 = [[0,0]', Muses(i).consOut(1).VolQdata'];
clf; plot(vq1(1,:), vq1(2,:)) , hold on, plot(VolTS.data(:,i), qTS.data(:,iCon1), '*r') 
title(Muses(i).name)

pw1 = PiecewiseLinearInterpolater(vq1);
%maxqbw = 6; %find way to estimate this from data
qbw = zeros(1,length(vq1));
qbw(3:end) = 1

vqf = vq1;
vqf(2,:) = qbw;
pwf = PiecewiseLinearInterpolater(vqf);

vq2 = [[0,0]', Muses(Muses(i).consOut(1).toMus).consOut(1).VolQdata'];
vqb = vq2;
vqb(2,:) = qbw;%backwards flow as func of downstream volume. 
pwb = PiecewiseLinearInterpolater(vqb);
%iterate for optimal qbw
%first qbw calculated as mean of (qobs - qSS) in range around the vols in vqf

clf; plot(vq1(1,:), vq1(2,:)) , hold on, plot(VolTS.data(:,i), qTS.data(:,iCon1), '*r')      % Plot only the time steps defined
plot(VolTS.data(:,i), qFromVolUsingPW(VolTS.data(:,i), pw1)+qFromVolUsingPW(VolTS.data(:,i), pwf)-qFromVolUsingPW(VolTS.data(:,i+1), pwb), '*c')      % Plot only the time steps defined

%plot(VolTS.data(:,i), qFromVolUsingPW(VolTS.data(:,i), pw1), '*c')      % Plot only the time steps defined
%plot(VolTS.data(:,i), qFromVolUsingPW(VolTS.data(:,i), pw1)+qFromVolUsingPW(VolTS.data(:,i), pwf)-qFromVolUsingPW(VolTS.data(:,i+1), pwb), '*c')      % Plot only the time steps defined





MusesWithBW = Muses;


end

