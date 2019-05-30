for a = 1:length(in_valid)
    %From input to the 1st hidden layer (including feedbacks)
    for y = 1:hl
        var_aux = 0;
        for x = 1:en
            if x==1
                var_aux = var_aux + W1(x,y)*in_valid(1,a);
            else
                var_aux = var_aux + W1(x,y)*1;  %bias
%                 var_aux = var_aux + 1;
            end
        end

        if a>1
            var_aux = var_aux + Wr(1,y)*Youtv(a-1);
        end

        if activ==1
            Y1v(y,1) = 1./(1 + exp(-var_aux));
        else
            Y1v(y,1) = tanh(var_aux);
        end
    end
    
    for y = 1:hl2
        var_aux = 0;
        for x = 1:hl
            var_aux = var_aux + Wl(x,y)*Y1v(x,1);
        end
        
        if a>1
            var_aux = var_aux + Wr(2,y)*Youtv(a-1);
        end
        
        if activ==1
            Y2v(y,1) = 1./(1 + exp(-var_aux));
        else
            Y2v(y,1) = tanh(var_aux);
        end
    end
    
    %From 2nd hidden layer to output
    var_aux = 0;
    for x = 1:hl2
        var_aux = var_aux + W2(x,1)*Y2v(x,1);
    end
    
    if out==1
        Youtv(a) = var_aux;
    elseif out==2
        if activ==1
            Youtv(a) = 1./(1 + exp(-var_aux));
        else
            Youtv(a) = tanh(var_aux);
        end   
    end
end