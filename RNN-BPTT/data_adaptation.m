for r = 1:h
    if a>r+1
        input(1,r) = in(1,a-1-r);
    end
end

for r = 1:h
    if a>r+1
        target(1,r) = Yd(1,a-1-r);
    end
end    