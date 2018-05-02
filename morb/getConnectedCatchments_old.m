function MusesWithCatchments = getConnectedCatchments(Muses, mexFile)

disp('getConnectedCatchments')
tic

fid = fopen(mexFile); 
bIsInCatchmentSection = false;

%musCons = 
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

            for(i=1:Nmuses)
                
               if(Muses(i).isNodeInMus( catchToNode{2})) % node1 is in  a selection
                   if(str2double(strtrim(splitline{4})) == 1)
                       imperv = str2double(strtrim(splitline{16}))/100;
                       redfactor = str2double(strtrim(splitline{19}));
                       area = str2double(strtrim(splitline{6}));
                       tc = str2double(strtrim(splitline{18}));
                       Muses(i).TAcatchments(end+1,:) = [area*redfactor*imperv, tc];
                   else
                      error('code do not support other than ta1 nonlocal cathc so fra') %this error does not make sense. 4 is not the right index for thsi.  
                   end
                               
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