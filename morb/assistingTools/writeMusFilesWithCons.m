function bsuccess= writeMusFilesWithCons( MusesWithCons, folder )
%write connections to two MUS files: one called ConsOut.mus with the
%outlets and one called CompCons.mus with the compartment connections

Muses = MusesWithCons;

bsuccess = 0;



for(k=1:2)
printOutlets = (k==1);
if(printOutlets) 
    filename = fullfile(folder, 'ConsOut.mus' );
else
    filename = fullfile(folder, 'CompCons.mus' );
end

%extract cons from muses
links = {};
weirs = {};
orifes = {};
pumps = {};


for i=1:length(Muses)
    for j=1:length(Muses(i).consOut)
        if(isempty(Muses(i).consOut(j).toMus) == printOutlets) %switch between outlets and compartment connections
            switch Muses(i).consOut(j).type
                case 'Link'
                    links{end+1} = Muses(i).consOut(j).name;
                case 'Weir'
                    weirs{end+1} = Muses(i).consOut(j).name;
                case 'Orifice'
                    orifes{end+1} = Muses(i).consOut(j).name;
                case 'Pump'
                    pumps{end+1} = Muses(i).consOut(j).name;
                otherwise
                    error(msg);
            end          
        end
    end
end

%print to file


if exist(filename, 'file')==2
    delete(filename);
end

fid = fopen(filename,'w');


linktagwritten = false;
weirtagwritten = false;
orificetagwritten = false;

if(~isempty(links))    
    fprintf(fid,'msm_Link\r\n');
end
for i=1:length(links), fprintf(fid,[links{i} ,'\r\n']);end; fprintf(fid,'\r\n');

if(~isempty(weirs))    
    fprintf(fid,'msm_Weir\r\n');
end
for i=1:length(weirs), fprintf(fid,[weirs{i} ,'\r\n']);end; fprintf(fid,'\r\n');

if(~isempty(orifes))    
    fprintf(fid,'msm_Orifice\r\n');
end
for i=1:length(orifes), fprintf(fid,[orifes{i} ,'\r\n']);end; fprintf(fid,'\r\n');

if(~isempty(pumps))    
    fprintf(fid,'msm_Pump\r\n');
end
for i=1:length(pumps), fprintf(fid,[pumps{i} ,'\r\n']);end; fprintf(fid,'\r\n');


fclose(fid);
end

