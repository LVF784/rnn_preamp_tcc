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
                end
            end
            
            field(1,y,r) = var_aux;
            
            %1st hl output
            if activ==1
                Y1(y,r) = 1./(1 + exp(-var_aux));
            else
                if y<ceil(0.3*hl)
                    Y1(y,r) = tanh(var_aux-xunxo);
                else
                    Y1(y,r) = tanh(var_aux);
                end
            end
        end
        
        for y = 1:hl2
            var_aux = 0;
            for x = 1:hl
                var_aux = var_aux + Wl(x,y)*Y1(x,r);
            end
            
            field(2,y,r) = var_aux;
            
            %2nd hl output
            if activ==1
                Y2(y,r) = 1./(1 + exp(-var_aux));
            else
                if y<ceil(0.3*hl)
                    Y2(y,r) = tanh(var_aux-xunxo);
                else
                    Y2(y,r) = tanh(var_aux);
                end
            end
        end
                
        var_aux = 0;
        for x = 1:hl2
            var_aux = var_aux + W2(x,1)*Y2(x,r);
        end
        
        %net output
        if out==1
            Yout(1,r) = var_aux;
        else
            if activ==1
                Yout(1,r) = 1./(1+exp(-var_aux));
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
                end
            end
            
            var_aux = var_aux + Wr(1,y)*Yout(1,r-1);
            
            field(1,y,r) = var_aux;
            
            %1st hl output
            if activ==1
                Y1(y,r) = 1./(1 + exp(-var_aux));
            else
                if y<ceil(0.3*hl)
                    Y1(y,r) = tanh(var_aux-xunxo);
                else
                    Y1(y,r) = tanh(var_aux);
                end
            end
        end
        
        for y = 1:hl2
            var_aux = 0;
            for x = 1:hl
                var_aux = var_aux + Wl(x,y)*Y1(x,r);
            end
            
            var_aux = var_aux + Wr(2,y)*Yout(1,r-1);
            
            field(2,y,r) = var_aux;
            
            %2nd hl output
            if activ==1
                Y2(y,r) = 1./(1 + exp(-var_aux));
            else
                if y<ceil(0.3*hl)
                    Y2(y,r) = tanh(var_aux-xunxo);
                else
                    Y2(y,r) = tanh(var_aux);
                end
            end
        end
        
        var_aux = 0;
        for x = 1:hl2
            var_aux = var_aux + W2(x,1)*Y2(x,r);
        end
        
        %net output
        if out==1
            Yout(1,r) = var_aux;
        else
            if activ==1
                Yout(1,r) = 1./(1+exp(-var_aux));
            else
                Yout(1,r) = tanh(var_aux);
            end
        end
      
    end
end     