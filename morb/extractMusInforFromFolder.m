function Muses = extractMusInforFromFolder( musfileFolder )
%EXTRACTMUSINFORFROMFOLDER Summary of this function goes here
%   Detailed explanation goes here
disp('extractMusInforFromFolder');
tic


ListOfMusFiles = dir(musfileFolder);

Nmuses = length(ListOfMusFiles)-2;
for i=1:Nmuses
    Muses(i) = singleMUS(ListOfMusFiles(i+2).name);
end

%tjeck for duplicates


for i=1:Nmuses
    %read mus file and add nodes and links to Muses(i)
    nameNoPath = [Muses(i).name,  '.mus'];
    filename = fullfile(musfileFolder, nameNoPath );
    fid = fopen(filename);
    
    %tline = fgetl(fid);
    
%     if(strcmp(tline, 'msm_Link') ~=1)
%         ERROR('first line should be msm_link in a mus file');
%     end
%     bInLinkSection = true;
%     bInNodeSection = false;
%     bInWeirSection = false;
%     bInOrificeSection = false;
    
    tline = fgetl(fid);
    while ischar(tline)
        % disp('...')
        % disp(tline);
        if(strcmp(tline, 'msm_Link') ==1)
            bInLinkSection = true;
            bInNodeSection = false;
            bInWeirSection = false;
             bInOrificeSection = false;
        elseif(strcmp(tline, 'msm_Node') ==1)
            bInLinkSection = 0;
            bInNodeSection = 1;
            bInWeirSection = 0;
            bInOrificeSection = 0;
        elseif(strcmp(tline, 'msm_Weir') ==1)      
            bInNodeSection = 0;
            bInWeirSection = 1;
            bInOrificeSection = 0;
        elseif(strcmp(tline, 'msm_Orifice') ==1)
            bInWeirSection = 0;
            bInOrificeSection = 1;
        elseif(isempty(tline))
            %do nothing
        elseif(bInLinkSection)
            Muses(i).links{end + 1} = tline;
        elseif(bInNodeSection)
            Muses(i).nodes{end + 1} = tline;
        elseif(bInWeirSection)
            Muses(i).links{end + 1} = tline;
        elseif(bInOrificeSection)
            Muses(i).links{end + 1} = tline;    
        end
        
        tline = fgetl(fid);
    end
    fclose(fid);
end


toc
end

