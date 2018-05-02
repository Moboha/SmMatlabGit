
[ LinkNames, coords1, coords2] = importNetworkFromMEX( 'C:\affald\Aarhus\CDS_rains\CDS_5\NW_CDS_5.mex');

figure
for i=1:length(LinkNames)
    plot([coords1(i).x,coords2(i).x],[coords1(i).y, coords2(i).y],'-k');
    hold on;
end

[NSEs, NSE30s, relSumEs, lags] =   scores2lists( scores );

%zz = NSE30s; %specific score to plot
zz = lags;

zzmax = max(zz)% overwrite if needed
zzmin = min(zz)
zzmin = -10;
zzmax = 10;


zzdif = zzmax-zzmin;
Ncolors = 20;
linecolors = jet(Ncolors);
colormap(jet)

for s=1:length(scores)
    s
    i = getnameidx(LinkNames, scores(s).name);
    z = ceil( (zz(s)-zzmin)/zzdif * Ncolors);
    if(z<1)
        z=1;
    elseif(z>Ncolors)
        z = Ncolors;
    elseif(isnan(z))
        z=1;
    end
    
    plot([coords1(i).x,coords2(i).x],[coords1(i).y, coords2(i).y],'LineWidth',8, 'color',linecolors(z,:));
    tx = text(mean([coords1(i).x,coords2(i).x]),mean([coords1(i).y, coords2(i).y]),scores(s).name);
    %tx.FontSize =9;
end

colorbar('Ticks',[0:0.2:1],'TickLabels',[0:0.2:1]*zzdif+zzmin)
