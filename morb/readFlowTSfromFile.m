function FlowTs = readFlowTSfromFile(prfAsCsv, listOfLinks)
disp('readFlowTSfromFile')
tic

Nlinks = length(listOfLinks);


fid = fopen(prfAsCsv);

firstLine = fgetl(fid);
fgetl(fid);
thirdLine = fgetl(fid);
fgetl(fid);

%check all links and weirs are in file (assuming that links and weirs have
%unik names. Assigning index in csv lines to listOfLinks entries.
linksToFileMap = zeros(Nlinks,1,'uint32');
split1 = strsplit(firstLine, {';'});
split2 = strsplit(thirdLine, {';'});
for i=1:length(split1)%trim entires for blankspaces
    split1{i} = strtrim(split1{i});
    split2{i} = strtrim(split2{i});
end


for i=1:length(split1)
   for j=1:Nlinks
      if(strcmp(split1{i}, listOfLinks{j})==1)
          if( strcmp(split2{i}, 'Link_Q') || strcmp(split2{i}, 'Weir_Q') || strcmp(split2{i}, 'Orifice_Q') || strcmp(split2{i}, 'Pump_Q'))
          linksToFileMap(j)=i;   
             %% break;
          end          
      end
   end      
end

for i=1:Nlinks
   if(linksToFileMap(i) == 0)
       msg = [' Cannot find link ', listOfLinks{i}]; 
       error(msg);      
   end
end


Nts = 0; %Number of steps in TS. 
while ~feof(fid)
     fgetl(fid);
     Nts = Nts + 1;
end
Nts
fclose(fid);

FlowTs.time = zeros(Nts,1);
FlowTs.data = zeros(Nts,Nlinks);


fid = fopen(prfAsCsv);
fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid); %read the four header lines
ti = 1;
a = 0;
disp('% done reading file:')
while ~feof(fid)
     tline = fgetl(fid);
     split = strsplit(tline, {';'});
    
     
     FlowTs.time(ti) =datenum(split{1}, 'yyyy-mm-dd HH:MM:SS');
     for j=1:Nlinks
        FlowTs.data(ti, j ) = str2double(strtrim(split{linksToFileMap(j)}));
     end
     
     ti = ti + 1;
      
b = floor((ti/Nts)*10); 
if(b>a)
    a=b; 
    disp([num2str(a*10), '%']);        
end
     
end

fclose(fid);

FlowTs.nameList = listOfLinks;
toc

end