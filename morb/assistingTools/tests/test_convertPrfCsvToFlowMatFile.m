function test_convertPrfCsvToFlowMatFile(  )
%TEST_CONVERTPRFCSVTOFLOWMATFILE Summary of this function goes here
%   Detailed explanation goes here

%PrfAsCsv =  'C:\affald\Validation\output.csv'; 
PrfAsCsv = 'R:\Research Communities\SurrogateModelling\Matlab\Source\Setting_up\morb\testData\fullPrfResults.csv';

matfile = 'C:\affald\Validation\affald.mat'; 
convertPrfCsvToFlowMatFile(PrfAsCsv, matfile);


end

