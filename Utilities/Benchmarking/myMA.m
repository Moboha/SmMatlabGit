function MAdata = myMA(inData, Nsteps)
MAdata = filter(ones(1, Nsteps)/Nsteps,1,inData);

end