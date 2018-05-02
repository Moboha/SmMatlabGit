function testBlanck2brack( )
%TESTBLANCK2BRACK Summary of this function goes here
%   Detailed explanation goes here


stringWithBlanks = 'bla bal bla';
stringWithoutBlanks = 'bla£bal£bla';

String2 = blank2brack(stringWithBlanks);

assert(strcmp(String2, stringWithoutBlanks));

String2 = brack2blank(stringWithoutBlanks);
assert(strcmp(String2, stringWithBlanks));

end

