%From input to the 1st hidden layer (including feedbacks)
for r = 1:h
    if r==1
        for y = 1:hl
            var_aux = 0;
            for x = 1:en
                if x==1
                    var_aux = var_aux + W1(x,y)*input(1,r);
                else
                    var_aux = var_aux + W1(x,y)*1;
%                     var_aux = var_aux + 1;
                end
            end
            
            %1st hl output
            if activ==1
                Y1(y,r) = 1./(1 + exp(-var_aux));
            else
                Y1(y,r) = tanh(var_aux);
            end
        end
        
        for y = 1:hl2
            var_aux = 0;
            for x = 1:hl
                var_aux = var_aux + Wl(x,y)*Y1(x,r);
            end
            %2nd hl output
            if activ==1
                Y2(y,r) = 1./(1 + exp(-var_aux));
            else
                Y2(y,r) = tanh(var_aux);
            end
        end
                
        var_aux = 0;
        for x = 1:hl2
            var_aux = var_aux + W2(x,1)*Y2(x,r);
        end
        %net output
        
        if out==1
            Yout(1,r) = var_aux;
        elseif out==2
            if activ==1
                Yout(1,r) = 1./(1 + exp(-var_aux));
            else
                Yout(1,r) = tanh(var_aux);
            end   
        end
        
    else
        
        for y = 1:hl
            var_aux = 0;
            for x = 1:en
                if x==1
                    var_aux = var_aux + W1(x,y)*input(1,r);
                else
                    var_aux = var_aux + W1(x,y)*1;
%                     var_aux = var_aux + 1;
                end
            end
            
            var_aux = var_aux + Wr(1,y)*Yout(1,r-1);
            
            
            %1st hl output
            if activ==1
                Y1(y,r) = 1./(1 + exp(-var_aux));
            else
                Y1(y,r) = tanh(var_aux);
            end
        end
        
        for y = 1:hl2
            var_aux = 0;
            for x = 1:hl
                var_aux = var_aux + Wl(x,y)*Y1(x,r);
            end
            
            var_aux = var_aux + Wr(2,y)*Yout(1,r-1);
            
            %2nd hl output
            if activ==1
                Y2(y,r) = 1./(1 + exp(-var_aux));
            else
                Y2(y,r) = tanh(var_aux);
            end
        end
        
        var_aux = 0;
        for x = 1:hl2
            var_aux = var_aux + W2(x,1)*Y2(x,r);
        end
        
        %net output
        if out==1
            Yout(1,r) = var_aux;
        elseif out==2
            if activ==1
                Yout(1,r) = 1./(1 + exp(-var_aux));
            else
                Yout(1,r) = tanh(var_aux);
            end   
        end
      
    end
end     