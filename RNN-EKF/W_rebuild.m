c = 1;

for x = 1:en
    for y = 1:hl
        W1(x,y) = W(c,1);
        c = c+1;
    end
end

for x = 1:hl
    for y = 1:hl2
        Wl(x,y) = W(c,1);
        c = c+1;
    end
end

for x = 1:2
    for y = 1:hl
        Wr(x,y) = W(c,1);
        c = c+1;
    end
end

for x = 1:hl2
    for y = 1:1
        W2(x,y) = W(c,1);
        c = c+1;
    end
end

c = 1;