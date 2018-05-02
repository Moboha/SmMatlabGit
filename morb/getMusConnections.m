function MusesWithCons = getMusConnections(Muses, mexFile)
disp('getMusConnections');
tic

if(checkMusForOverlaps(Muses))
    error('Some nodes and/or links are found in several muses')
end

Nmuses = length(Muses);


fid = fopen(mexFile);
bIsInLinksSection = false;
bIsInWeirSection = false;
bIsInOrificeSection = false;
bInInPumpSection = false;
%musCons =
nCons = 0;

while ~feof(fid)
    tline = fgetl(fid);
    
    if(bIsInLinksSection  || bIsInWeirSection || bIsInOrificeSection || bInInPumpSection)
        splitline = strsplit(tline, {'\t', ',' ,'='} );
        % disp(splitline);
        readType = strtrim(splitline{1});
        if( strcmp( readType, 'Link')  || strcmp( readType, 'Weir') ||strcmp(readType, 'Orifice') || strcmp(readType, 'Pump') )
            %disp(splitline);
            %find endnodes in muses. If in more than one then error
            
            node1str = strsplit(splitline{3}, {''''} );
            node2str = strsplit(splitline{4}, {''''} );
            
            node2mus = 0;
            
            for(i=1:Nmuses)
                
                if(Muses(i).isNodeInMus( node1str{2})) % node1 is in  a selection
                    for(j=1:Nmuses)
                        if(Muses(j).isNodeInMus( node2str{2}))
                            node2mus = j;
                            break
                        end
                    end
                    
                    if(node2mus == i)% both nodes are in same mus so do nothing.
                        break;
                        
                    else
                        
                        Muses(i).consOut(end+1)= musCon();
                        nCons = nCons+ 1;
                        % Muses(i).consOut(end).connectionNo = nCons;
                        
                        linknamesplit = strsplit(splitline{2}, {''''} );
                        Muses(i).consOut(end).name = linknamesplit{2};
                        Muses(i).consOut(end).type = readType;
                        if(node2mus == 0) %node2 not in any mus
                            Muses(i).consOut(end).outlet = node2str{2};
                        else %node2 is in another mus
                            Muses(i).consOut(end).toMus = node2mus;
                        end
                    end
                    
                end
            end
            
            
            
            %if link is in mus file see if both end nodes are in same mus -
            %if this is the case then proceed to next link. If not then
            %search for the other node in the other muses. If not found
            %then save endpoint as outlet. The user can then inspect the
            %outlets in the prm file and aggregate them if required .
            
            
            
            
        else
            if( strcmp(splitline{1}, 'EndSect  // MOUSE_LINKS'))
                bIsInLinksSection = false;
            end
            if( strcmp(splitline{1}, 'EndSect  // MOUSE_WEIRS'))
                bIsInWeirSection = false;
            end
            if( strcmp(splitline{1}, 'EndSect  // MOUSE_ORIFICES'))
                bIsInOrificeSection = false;
            end
            if( strcmp(splitline{1}, 'EndSect  // MOUSE_PUMPS'))
                bInInPumpSection = false;
            end
        end
        
    end
    if(bIsInLinksSection == false)
        if( strcmp(tline, '[MOUSE_LINKS]'))
            bIsInLinksSection = true;
        elseif( strcmp(tline, '[MOUSE_WEIRS]'))
            bIsInWeirSection = true;
        elseif( strcmp(tline, '[MOUSE_ORIFICES]'))
            bIsInOrificeSection = true;
        elseif( strcmp(tline, '[MOUSE_PUMPS]'))
            bInInPumpSection = true;
        end
    end
end



fclose(fid);

%add index to connections
index = 1;
for i=1:length(Muses)
    
    for j=1:length(Muses(i).consOut)
        Muses(i).consOut(j).connectionNo = index;
        index = index + 1;
    end
end

MusesWithCons = Muses;
toc
end








