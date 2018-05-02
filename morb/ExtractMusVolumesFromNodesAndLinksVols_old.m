function MusVolumeTS = ExtractMusVolumesFromNodesAndLinksVols( Muses, NodeVolumeFile, LinksVolumenFile )
%EXTRACTVOLUMESFROM Summary of this function goes here
%   Detailed explanation goes here
disp('ExtractMusVolumesFromNodesAndLinksVols')


%get all node n link ids from mus files
%Muses(length(ListOfMusFiles)) = singleMUS();
%Muses = extractMusInforFromFolder(musFileFolder);
Nmus = length(Muses);
%allocate ts memory

fid = fopen(NodeVolumeFile);
Nts = -1; %Number of steps in TS. -1 to correct for header and blank line in the end.
while ~feof(fid)
    fgetl(fid);
    Nts = Nts + 1;
end
fclose(fid);
VolTS.data = zeros(Nts, Nmus+1);
VolTS.time = zeros(Nts,1);



%*******************get node volumes*************************
fid = fopen(NodeVolumeFile);
tline = fgetl(fid);
splitline = strsplit(tline, {' \t'});
MUIDs = splitline(2:end);
Nnodes = length(MUIDs)


%
tic
node2volMap = zeros(Nnodes,1,'uint32');% 
for(i=1:Nnodes)
    for(j=1:Nmus)
        if(Muses(j).isNodeInMus(MUIDs{i}))
        node2volMap(i) = j;
        break;
        end
    end
end
node2volMap(node2volMap==0)=Nmus+1;%nodes not in any mus assigned to Nmus+1
toc
tic


%read results and aggregate for mus for each time step. 
ti=1;
while ~feof(fid)
    tline = fgetl(fid);
    split = strsplit(tline);
    for(i=3:Nnodes)
        index = node2volMap(i);
        VolTS.data(ti,index) = VolTS.data(ti,index) + str2double(split{i+2});
    end
    
    VolTS.time(ti) =datenum([split{1} ' ' split{2}], 'dd-mm-yyyy HH:MM:SS');
    ti=ti+1;
end
fclose(fid);
toc
%link2volMap

%*******************get link volumes*************************
fid = fopen(LinksVolumenFile);
tline = fgetl(fid);
splitline = strsplit(tline, {' \t'});
MUIDs = splitline(3:end);
Nlinks = length(MUIDs)


%
links2volMap = zeros(Nlinks,1,'uint32');% 
for(i=1:Nlinks)
    for(j=1:Nmus)
        if(Muses(j).isLinkInMus(MUIDs{i}))
        links2volMap(i) = j;
        break;
        end
    end
end
links2volMap(links2volMap==0)=Nmus+1;%nodes not in any mus assigned to Nmus+1


ti=1;
while ~feof(fid)
    tline = fgetl(fid);
    split = strsplit(tline);
    for(i=3:Nlinks)
        index = links2volMap(i);
        
        VolTS.data(ti,index) = VolTS.data(ti,index) + str2double(split{i});
    end
    ti=ti+1;
end
fclose(fid);



%***************************************

VolTS.nameList = {};
for j=1:Nmus 
    VolTS.nameList{end+1} = Muses(j).name;
end

MusVolumeTS = VolTS;




end

