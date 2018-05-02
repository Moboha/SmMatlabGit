function plotAllQVolFromMus(Mus )

figure
for i=1:(length(Mus.consOut))     
vq = Mus.consOut(i).VolQdata;
plot(vq(:,1), vq(:,2),'-*')
hold on
end
title(Mus.name)
xlabel('Vol')
ylabel('q')
end


