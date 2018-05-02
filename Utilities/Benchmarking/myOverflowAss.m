function  CSOstats = myOverflowAss( observed, modelled, eventSeperationInSteps )


    %observed and modelled are vectors with values syncronized in time
    %
    %Assesment 1: How many was modelled correctly,and how many false
    %alarms.
    Nsteps = length(observed);
    
    observed = observed.*(observed>0);%removes negative values
    modelled = modelled.*(modelled>0);
    
    obsMa = filter(ones(1,eventSeperationInSteps),1, observed);
    modMa = filter(ones(1,eventSeperationInSteps),1, modelled);

    
    mbinA = modMa(:)>0;mbinA = [mbinA; 0];
    Nmod = sum((mbinA(2:end) - mbinA(1:end-1)) == 1);
    
    obinA = obsMa(:)>0;obinA = [obinA; 0];%event or not
    Nobs = sum((obinA(2:end) - obinA(1:end-1)) == 1);
    
    obsEventDetected = zeros(Nobs,1);
    
    ie = 1;%event index
    for i=1:Nsteps       
        if obinA(i)
            if mbinA(i)
                obsEventDetected(ie) = 1;
            end
            if(obinA(i+1) == 0)
               ie = ie +1 ; 
            end
        end
     
    end
     
    falseAlarms = ones(Nmod,1);
    ie = 1;%event index
    for i=1:Nsteps       
        if mbinA(i)
            if obinA(i)
                falseAlarms(ie) = 0;
            end
            if(mbinA(i+1) == 0)
               ie = ie +1 ; 
            end
        end
     
    end
NfalseAlarms = sum(falseAlarms);
Npredicted  = sum(obsEventDetected);

CSOstats.Nobs = Nobs;
CSOstats.Nmod = Nmod;
CSOstats.Npredicted = Npredicted;
CSOstats.NfalseAlarms = NfalseAlarms;

end

