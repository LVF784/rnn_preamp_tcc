Delta_W2 = zeros(hl2,1);
for r = 1:h
    for y = 1:hl2
        Delta_W2(y,1) = Delta_W2(y,1) + eta*dYout(1,r)*Y2(y,r);
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

Delta_Wl = zeros(hl, hl2);
for r = 1:h
    for x = 1:hl
        for y = 1:hl2
            Delta_Wl(x,y) = Delta_Wl(x,y) + eta*dY2(y,r)*Y1(x,r);
        end
    end
end
Wl = Wl + Delta_Wl;

Delta_Wr = zeros(2,hl);
for r = h:-1:2
    for y = 1:hl
        Delta_Wr(1,y) = Delta_Wr(1,y) + eta*dY1(y,r)*Yout(1,r-1);
    end
    for y = 1:hl2
        Delta_Wr(2,y) = Delta_Wr(2,y) + eta*dY2(y,r)*Yout(1,r-1);
    end
end
Wr = Wr + Delta_Wr;
