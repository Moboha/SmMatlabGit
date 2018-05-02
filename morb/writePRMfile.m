
function writePRMfile(MusesWithCatchments, VolTS, qTS, PRMfile, samplingIndex)
Muses = MusesWithCatchments; %for easy reference.


if exist(PRMfile, 'file')==2
    delete(PRMfile);
end

fid = fopen(PRMfile,'w');

%% Section for simulation data is created
fprintf(fid,'[SimulationData] \r\n');


fprintf(fid,'/>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> \r\n');
fprintf(fid,'[HydraulicModel] \r\n');
fprintf(fid,'************************************************** \r\n');

for i=1:length(Muses)
    for j=1:length(Muses(i).consOut)
        %if(strcmp(Muses(i).consOut(j).outlet, '') ~= 1)
        if (isempty(Muses(i).consOut(j).toMus))
            %TODO check if it has been written
            %fprintf(fid,['\t<name> ', Muses(i).consOut(j).outlet,'\n']);
            fprintf(fid,['\t<name> ', Muses(i).consOut(j).name,'\n']);
            fprintf(fid,['\t<type>\t outlet\n']);
            fprintf(fid,'************************************************** \r\n');
        end
    end
end


flowIndex = 1;
for i=1:length(Muses)
    
    
    SMname = Muses(i).name;
    fprintf(fid,['\t<name> ', SMname,'\n']);
    fprintf(fid,'\t<type>	drainage \r\n');
    
    for j=1:length(Muses(i).consOut)
        
        if (~isempty(Muses(i).consOut(j).toMus))%not an outlet
            toindex = Muses(i).consOut(j).toMus;
            fprintf(fid,['\t<connection>\t', Muses(toindex).name , ' PieceWiseLinRes\t (0,0;']);
            
        else
            fprintf(fid,['\t<connection>\t', Muses(i).consOut(j).name, ' PieceWiseLinRes\t (0,0;']);%have changed from outlet to link name
        end
        %
        for k=1:length(samplingIndex)
            
            q = qTS.data(samplingIndex(k),flowIndex);
            vol = VolTS.data(samplingIndex(k),i);
            fprintf(fid, [num2str(vol),',',num2str(q)]);
            if(k<length(samplingIndex))
                fprintf(fid, ';');                
            end
            
        end
        
        fprintf(fid,')');
        fprintf(fid, [' /', Muses(i).consOut(j).name]);
        fprintf(fid,'\r\n');
        flowIndex = flowIndex + 1;
        
    end
    fprintf(fid,'************************************************** \r\n');
    
end
fprintf(fid,'[EndSect] \r\n');
fprintf(fid,'/>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> \r\n');

%% Section for Runoff
fprintf(fid,'[Runoff] \r\n');
fprintf(fid,'[SurfaceModels] \r\n');
for i=1:length(Muses)
    sumArea = 0;
    sumTCA = 0;
    for(j=1:length(Muses(i).TAcatchments(:,1)))
        sumArea = sumArea + Muses(i).TAcatchments(j,1);
        sumTCA = sumTCA + Muses(i).TAcatchments(j,1)*Muses(i).TAcatchments(j,2);
    end
    
    
    fprintf(fid,['\t<SurfMod>\t', Muses(i).name, '\tTA1\t(', num2str(round(sumArea*10000)), ',', num2str(round(sumTCA/sumArea)),')\r\n']);
end


fprintf(fid,'[EndSect] \r\n');
fprintf(fid,'[EndSect] \r\n');
fprintf(fid,'/>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> \r\n');
fclose(fid);

end
