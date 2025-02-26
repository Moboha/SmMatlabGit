function [ raw ] = ReadCsv( filename, startRow, endRow , startCol, endCol)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [TITLE1,PRICE,MAXRUNS,REQUIREDSKILLS,REQUIREDINPUTMATERIALS,VARNAME6,OUTCOME,VARNAME8]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [TITLE1,PRICE,MAXRUNS,REQUIREDSKILLS,REQUIREDINPUTMATERIALS,VARNAME6,OUTCOME,VARNAME8]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [Title1,Price,MaxRuns,RequiredSkills,RequiredInputMaterials,VarName6,Outcome,VarName8]
%   = importfile('EVE Online - Blueprints.csv',1, 7);
%
%    See also TEXTSCAN.

%% Initialize variables. 
delimiter = ';\t';
if nargin<2
    startRow = 1;
    endRow = inf;
    startCol = 1;
    endCol = inf;
end

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
%Rem_columns = repmat('%*s',1,21923);
Disp_columns = repmat('%s',startCol,endCol);
%Disp_columns = '%s';
formatSpec = strcat(Disp_columns, '%[^\n\r]');%,'BufSize',40950);
%formatSpec = '%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

% Converts strings in the input cell array to numbers. Replaced non-numeric
% strings with NaN.
rawData = dataArray{6};
for row=1:size(rawData, 1);
    % Create a regular expression to detect and remove non-numeric prefixes and
    % suffixes.
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData{row}, regexstr, 'names');
        numbers = result.numbers;
        
        % Detected commas in non-thousand locations.
        invalidThousandsSeparator = false;
        if any(numbers==',');
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(thousandsRegExp, ',', 'once'));
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        % Convert numeric strings to numbers.
        if ~invalidThousandsSeparator;
            numbers = textscan(strrep(numbers, ',', ''), '%f');
            numericData(row, 6) = numbers{1};
            raw{row, 6} = numbers{1};
        end
    catch me
    end
end

end

