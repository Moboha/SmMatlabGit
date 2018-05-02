function outString = blank2brack( inString )

outString = strrep(inString,' ','++');

outString = strrep(outString,'Å','+AA+');


end

