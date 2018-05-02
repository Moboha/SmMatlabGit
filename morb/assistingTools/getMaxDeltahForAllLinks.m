function getMaxDeltahForAllLinks(prfAsCsv, folderForMusFiles)
%prfAsCsv needs to be with both q and h in links. 
%Code produces mus with :
%       1. all links with max delta h over x meter
%       2. links with max buildup of wl aginst the flow direction of min x
%       m
%       3. links wher the water depth decreases agains the flow. 

savefolder = folderForMusFiles;

listOfLinks = {};
listOfIndexs = int32.empty();%first h point
listOfIndexs2 = int32.empty();%second h point

fid = fopen(prfAsCsv);
firstLine = fgetl(fid);
fgetl(fid);
thirdLine = fgetl(fid);
fgetl(fid);

split1 = strsplit(firstLine, {';'});
split2 = strsplit(thirdLine, {';'});
for i=1:length(split1)%trim entires for blankspaces
    split1{i} = strtrim(split1{i});
    split2{i} = strtrim(split2{i});
end

h1 = 0;
for i=1:length(split1)
          if( (strcmp(split2{i}, 'Link_WL')==1))
              if(isempty(listOfLinks) || (strcmp(split1{i}, listOfLinks{end} )==0))%link is not in list
              listOfLinks{end+1} = strtrim(split1{i});
              listOfIndexs(end+1) = i;
              else%if link is already in list
                  if(~isempty(listOfLinks))
                      listOfIndexs2(length(listOfIndexs)) = i;
                  end
                  
              end
          end              
end


Nlinks  = length(listOfIndexs);


Nts = 0; %Number of steps in TS. 
while ~feof(fid)
     fgetl(fid);
     Nts = Nts + 1;
end
Nts
fclose(fid);

Qhs.time = zeros(Nts,1);
Qhs.dh = zeros(Nts,Nlinks);

fid = fopen(prfAsCsv);
fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid); %read the four header lines
ti = 1;
while ~feof(fid)
     tline = fgetl(fid);
     split = strsplit(tline, {';'});
          
     Qhs.time(ti) =datenum(split{1}, 'yyyy-mm-dd HH:MM:SS');
     for(j=1:Nlinks)
        Qhs.dh(ti, j ) = str2double(strtrim(split{listOfIndexs2(j)})) - str2double(strtrim(split{listOfIndexs(j)})); %
     end   
     ti = ti + 1;
end
fclose(fid);

absDH = abs(Qhs.dh);
[maxabsDh, I] = max(absDH,[],1);

pipedrop = Qhs.dh(1,:);
buildup = -Qhs.dh +  pipedrop(ones(size(Qhs.dh,1),1),:); % change in dh compared to pipe slope (dh at t 1)


%max abs dh ->mus
biggerThan = [1, 2, 3, 4, 5, 6];
for i=1:length(biggerThan)
       
savename =  [savefolder, 'dhAbove' , num2str(biggerThan(i)), 'm.mus']
writeLinksToMUSfile( listOfLinks(maxabsDh >biggerThan(i)), savename);

end

maxbuildup = max(buildup, [], 1);
%max buildup ->mus
    
biggerThan = [0 , 1, 2];
for i=1:length(biggerThan)
savename =   [savefolder,   'buildup' , num2str(biggerThan(i)), 'm.mus']
writeLinksToMUSfile( listOfLinks(maxbuildup >biggerThan(i)), savename);
end


minfalldown = min(buildup, [], 1);

savename =   [savefolder,   'fallDown0m.mus']
writeLinksToMUSfile( listOfLinks(minfalldown<0), savename);

savename =   [savefolder,   'fallDown02m.mus']
writeLinksToMUSfile( listOfLinks(minfalldown<-0.2), savename);

savename =   [savefolder,   'fallDown1m.mus']
writeLinksToMUSfile( listOfLinks(minfalldown<-1), savename);






