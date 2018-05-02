function convertPrfCsvToFlowMatFile( prfAsCsv, matFile )

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

listOfLinks = {};
currentLink = '';
for i=1:length(split1)
    
    if(strcmp(split1{i}, currentLink)==0)
        if( (strcmp(split2{i}, 'Link_Q')==1) || (strcmp(split2{i}, 'Weir_Q')==1) || (strcmp(split2{i}, 'Orifice_Q')==1 )|| (strcmp(split2{i}, 'Pump_Q')==1 ))
            listOfLinks{end+1} = split1{i};
            %% break;
        end
    end
    
end

fclose(fid);
FlowTS = readFlowTSfromFile(prfAsCsv, listOfLinks);
FlowTS.nameList = listOfLinks;
save(matFile, 'FlowTS');

end

