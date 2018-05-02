function  plotSingleLink2( xx, tt, FlowTS, linkName)
%xx is the results collection from the SM model
%tt is the correspoding time
%FlowTS have to include FlowTS.nameList that is a list of link names
%corresponding to the data in the TS
%vers 2 also handles bw links

listOfOutputsFromSM = {};
for i=1:xx.Length
    listOfOutputsFromSM{end+1} = brack2blank(char(xx(i).name));
end

    i = getnameidx(listOfOutputsFromSM, linkName);
    resx = xx(i);   
    values = resx.data.ToArray.double;
    
    i = getnameidx(listOfOutputsFromSM, [linkName, '(BW)']);
    if(i>0)
    resx = xx(i);   
    valuesBw = resx.data.ToArray.double;
    values = values - valuesBw;
    end
    
    plot(tt.double/3600, values, '-b' ); hold on
    hold on
    
    i = getnameidx(FlowTS.nameList, linkName);   
    plot( (FlowTS.time - FlowTS.time(1))*24, FlowTS.data(:,i), '-r');
   
    title( linkName );
    xlabel('time [h]')

end

