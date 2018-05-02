function writeLinksToMUSfile( listOfLinks, filename )

links = listOfLinks;

if exist(filename, 'file')==2
    delete(filename);
end

fid = fopen(filename,'w');
fprintf(fid,'msm_Link\r\n');

for i=1:length(links)
    fprintf(fid,[links{i} ,'\r\n']);
end; 

fprintf(fid,'\r\n');

fclose(fid);
end


