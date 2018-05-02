function [conn1,index1 ,conn2, index2] = findConnection( model, fromName, toName )
%FIND Summary of this function goes here
%   There might be more than one connection between two compartments.

conn1 = []; conn2=[];

conns = model.getConnections;

N = model.lengthOfStateVector;
Nconns = conns.Count;

for i=0:N-1
    if strcmp(char(model.getNodeName(i)), fromName)
        for j=0:N-1
            if strcmp(char(model.getNodeName(j)), toName)               
                for z = 0:Nconns-1
                    con = conns.Item(z);
                    if (con.from == i)&&(con.to == j)
                        
                        if(isempty(conn1))
                            conn1 = con;
                            index1 = z;
                        else
                            conn2 = con;
                            index2 = z;
                        end                     
                    end                   
                end
            end
        end
    end        
end

end

