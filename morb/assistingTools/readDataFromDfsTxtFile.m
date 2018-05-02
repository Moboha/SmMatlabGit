function TS = readDataFromDfsTxtFile( txtFile )
%READDATAFROMDFSTXTFILE Summary of this function goes here
%  appox a minute for 5 years of data.


fid = fopen(txtFile);
Nts = -2; %Number of steps in TS. -1 to correct for header and blank line in the end.
while ~feof(fid)
    fgetl(fid);
    Nts = Nts + 1;
end
fclose(fid);

TS.data = zeros(Nts, 1);
TS.time = zeros(Nts,1);


fid = fopen(txtFile);
tline = fgetl(fid);
tline = fgetl(fid);

ti=1;
while ~feof(fid)
    tline = fgetl(fid);
    split = strsplit(tline,{' ','\t'});
    TS.data(ti) = str2double(split{3});
    TS.time(ti) =datenum([split{1} ' ' split{2}], 'yyyy-mm-dd HH:MM:SS');
    ti=ti+1;
end

fclose(fid)

end

