
clear all
basefolder = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up';

%prfAsCsv =[basefolder, '\morb\testData\fullPrfResults.csv'];%should be cds or historical. 
prfAsCsv =[basefolder, '\frri\testData\fullPrfResults.csv'];%should be cds or historical. 



listOfLinks = {};
listOfIndexs = int32.empty();

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


for i=1:length(split1)
          if( (strcmp(split2{i}, 'Link_Q')==1))
              if(isempty(listOfLinks) || (strcmp(split1{i}, listOfLinks{end} )==0))
              listOfLinks{end+1} = strtrim(split1{i});
              listOfIndexs(end+1) = i;
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
Qhs.Q = zeros(Nts,Nlinks);
Qhs.h = zeros(Nts,Nlinks);


fid = fopen(prfAsCsv);
fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid); %read the four header lines
ti = 1;
while ~feof(fid)
     tline = fgetl(fid);
     split = strsplit(tline, {';'});
     
     
     Qhs.time(ti) =datenum(split{1}, 'yyyy-mm-dd HH:MM:SS');
     for(j=1:Nlinks)
        Qhs.Q(ti, j ) = str2double(strtrim(split{listOfIndexs(j)}));
        Qhs.h(ti, j ) = (str2double(strtrim(split{listOfIndexs(j)-1})) + str2double(strtrim(split{listOfIndexs(j)+1})))/2; %average between neighbouring wl points
     end
     
     ti = ti + 1;
end

fclose(fid);

%'''''''''''' Get




