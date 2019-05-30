Delta_W2 = zeros(hl,1);
for r = 1:h-1
    for y = 1:hl
        Delta_W2(y,1) = Delta_W2(y,1) + eta*dY2(1,r)*Y1(y,r);
    end
end
W2 = W2 + Delta_W2;

Delta_W1 = zeros(en,hl);
for r = 1:h
    for y = 1:hl
        for x = 1:en
            if x==1
                Delta_W1(x,y) = Delta_W1(x,y) + eta*dY1(y,r)*input(1,r);
            else
                Delta_W1(x,y) = Delta_W1(x,y) + eta*dY1(y,r)*1;
            end
        end
    end
end
W1 = W1 + Delta_W1;

Delta_Wr = zeros(1,hl);
for r = h-1:-1:1
    for y = 1:hl
        Delta_Wr(1,y) = Delta_Wr(1,y) + eta*dY1(y,r)*Yout(1,r+1);
    end
end
Wr = Wr + Delta_Wr;