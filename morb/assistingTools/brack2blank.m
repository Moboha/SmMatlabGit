function outString= brack2blank( inString )


outString = strrep(inString,'++',' ');

outString = strrep(outString,'+AA+','Å');


end

