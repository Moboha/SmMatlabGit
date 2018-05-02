function NSout = myNSE( measured, modelled )

        E = measured - modelled;
        SSE = sum(E.^2);
        u = mean(measured);
        SSU = sum((measured - u).^2);

        NSout = 1 - SSE/SSU;

end

