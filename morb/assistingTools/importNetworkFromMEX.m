function [ LinkNames, coords1, coords2] = importNetworkFromMEX( mexFile )
%IMPORTNETWORKFROMMEX Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(mexFile);
bIsInLinksSection = false;
bIsInWeirSection = false;
bIsInOrificeSection = false;
bIsInNodesSection = false;
bIsInPumpsSection = false;

LinkNames = {};
coords1.x = {};
coords1.y = {};
coords2.x = {};
coords2.y = {};
iLink = 0;

NodeNames = {};
coordNodes.x = {};
coordNodes.y = {};
iNode=0;

while ~feof(fid)
    tline = fgetl(fid);
    
    if(bIsInLinksSection == true || bIsInWeirSection || bIsInOrificeSection || bIsInPumpsSection)
        splitline = strsplit(tline, {'\t', ',' ,'='} );
        % disp(splitline);
        readType = strtrim(splitline{1});
        if( strcmp( readType, 'Link') == 1 || strcmp( readType, 'Weir') == 1||strcmp(readType, 'Orifice') == 1 || strcmp(readType, 'Pump') == 1)
            %disp(splitline);
            %find endnodes in muses. If in more than one then error
            
            node1str = strsplit(splitline{3}, {''''} );
            node2str = strsplit(splitline{4}, {''''} );
            linknamesplit = strsplit(splitline{2}, {''''} );
            iLink = iLink+1;
            LinkNames{iLink} = linknamesplit{2};
            
            
            FromNodeName = node1str{2};
            ToNodeName = node2str{2};
            i = getnameidx(NodeNames, strtrim(FromNodeName));
            
            coords1(iLink).x = coordNodes(i).x;
            coords1(iLink).y = coordNodes(i).y;
            
            if(isempty(ToNodeName))
                coords2(iLink).x = coords1(iLink).x - 100;
                coords2(iLink).y = coords1(iLink).y;
            else
            i = getnameidx(NodeNames, ToNodeName); 
            coords2(iLink).x = coordNodes(i).x;
            coords2(iLink).y = coordNodes(i).y;
            end
            
         

            
            
            
        else
            if( strcmp(splitline{1}, 'EndSect  // MOUSE_LINKS') == 1)
                bIsInLinksSection = false;
            end
            if( strcmp(splitline{1}, 'EndSect  // MOUSE_WEIRS') == 1)
                bIsInWeirSection = false;
            end
            if( strcmp(splitline{1}, 'EndSect  // MOUSE_ORIFICES') == 1)
                bIsInOrificeSection = false;
            end
            if( strcmp(splitline{1}, 'EndSect  // MOUSE_PUMPS') == 1)
                bIsInPumpsSection = false;
            end
            
        end    
    elseif(bIsInNodesSection)
        splitline = strsplit(tline, {'\t', ',' ,'='} );
         readType = strtrim(splitline{1});
        if( strcmp( readType, 'Node') == 1)
            namesplit = strsplit(splitline{2}, {''''} );
            name = namesplit{2};
            iNode =iNode+1;
            NodeNames{iNode} = name;
            coordNodes(iNode).x = str2double(splitline{4});
            coordNodes(iNode).y = str2double(splitline{5});

            
        end
        
    end
    
    
    
    
    if(bIsInLinksSection == false)
        if( strcmp(tline, '[MOUSE_LINKS]') == 1)
            bIsInLinksSection = true;
        elseif( strcmp(tline, '[MOUSE_WEIRS]') == 1)
            bIsInWeirSection = true;
        elseif( strcmp(tline, '[MOUSE_ORIFICES]') == 1)
            bIsInOrificeSection = true;
        elseif( strcmp(tline, '[MOUSE_PUMPS]') == 1)
            bIsInPumpsSection = true;
        end
    end
    if(bIsInNodesSection == false)
       
        if( strcmp(tline, '[MOUSE_NODES]') == 1)
            
            bIsInNodesSection = true;
        end

    end
    
    
end



fclose(fid);


figure, for i=2:length(LinkNames), plot([coords1(i).x,coords2(i).x],[coords1(i).y, coords2(i).y],'-k'), hold on, end


end

