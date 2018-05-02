function q = qFromVolUsingPW(vols, pw)
Ndata = length(vols);
q = zeros(Ndata,1);
for i=1:Ndata
    
    q(i) = pw.calcValue(vols(i));
    


end
