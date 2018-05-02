function MusesWithCatchments = getConnectedCatchments2(Muses, mexFile)

disp('getConnectedCatchments')
tic

%get model A data sets%

fid = fopen(mexFile);
bInModelAsection = false;
i = 0;
while ~feof(fid)
    tline = fgetl(fid);
    splitline = strsplit(tline, {'\t', ',' ,'='} );
    if(~bInModelAsection && strcmp(tline, '[Model_A]') == 1)
        bInModelAsection = true;
    end   
    if( bInModelAsection && strcmp(splitline{1}, 'EndSect  // Model_A') == 1)
        bInModelAsection = false;
    end
    
    if( bInModelAsection && strcmp(strtrim(splitline{1}), 'Line') == 1)
      i=i+1;
      setA(i).name = strtrim(splitline{2});
      setA(i).tc = str2double(strtrim(splitline{6}));
      setA(i).RED = str2double(strtrim(splitline{3}));      
    end
    
end
fclose(fid);
%*******

fid = fopen(mexFile);
bIsInCatchmentSection = false;

Nmuses = length(Muses);

while ~feof(fid)
    tline = fgetl(fid);
    
    if(bIsInCatchmentSection == true)
        splitline = strsplit(tline, {'\t', ',' ,'='} );
        % disp(splitline);
        if( strcmp(strtrim(splitline{1}), 'Line') == 1)
            %disp(splitline);
            %find endnodes in muses. If in more than one then error
            
            catchToNode = strsplit(splitline{2}, {''''} );
            
            for i=1:Nmuses
                
                if(Muses(i).isNodeInMus( catchToNode{2})) % node1 is in  a selection
                        area = str2double(strtrim(splitline{6}));                    
                        imperv = str2double(strtrim(splitline{16}))/100;                   
                    if(strcmp(strtrim(splitline{17}), 'true'))%use local parameters
                        redfactor = str2double(strtrim(splitline{19}));
                        tc = str2double(strtrim(splitline{18}));                     
                    else
                        tc = NaN;
                        redfactor = NaN;
                        for z=1:length(setA)
                            if(strcmp(setA(z).name, strtrim(splitline{15})) ==1)
                               redfactor = setA(z).RED;
                               tc = setA(z).tc;
                                break
                            end
                        end

                    end
                     Muses(i).TAcatchments(end+1,:) = [area*redfactor*imperv, tc];
                end
            end
            
            
        elseif( strcmp(splitline{1}, 'EndSect  // MOUSE_Catchments') == 1)
            bIsInCatchmentSection = false;
        end
        
    end
    if(bIsInCatchmentSection == false)
        if( strcmp(tline, '[MOUSE_Catchments]') == 1)
            bIsInCatchmentSection = true;
        end
    end
end

MusesWithCatchments = Muses;

toc
end