for r = h:-1:1
    if r==h
        dYouts = 1;
        if out==1
            dYout(1,r) = dYouts*1;
        else
            if activ==1
                dYout(1,r) = Yout(1,r)*(1 - Yout(1,r))*dYouts;
            else
                dYout(1,r) = (1 - (Yout(1,r)).^2)*dYouts;
            end
        end

        for y = 1:hl2
            dY2s(y) = W2(y,1)*dYout(1,r);
%             dY1s(y) = 1;
            if activ==1
                dY2(y,r) = dY2s(y)*Y2(y,r)*(1 - Y2(y,r));
            else
                dY2(y,r) = dY2s(y)*(1 - (Y2(y,r)).^2);
            end
        end

        for y = 1:hl
            dY1s(y) = 0;
            for x = 1:hl2
                dY1s(y) = dY1s(y) + dY2(x,r)*Wl(y,x);
            end
            if activ==1
                dY1(y,r) = dY1s(y)*Y1(y,r)*(1 - Y1(y,r));
            else
                dY1(y,r) = dY1s(y)*(1 - (Y1(y,r)).^2);
            end
        end

    else

        dYouts = 0;
        for x = 1:hl2
            dYouts = dYouts + Wr(1,x)*dY1(x,r+1);
            dYouts = dYouts + Wr(2,x)*dY2(x,r+1);
        end
        if out==1
            dYout(1,r) = dYouts*1;
        else
            if activ==1
                dYout(1,r) = Yout(1,r)*(1 - Yout(1,r))*dYouts;
            else
                dYout(1,r) = (1 - (Yout(1,r)).^2)*dYouts;
            end
        end

        for y = 1:hl2
            dY2s(y) = W2(y,1)*dYout(1,r);
            if activ==1
                dY2(y,r) = dY2s(y)*Y2(y,r)*(1 - Y2(y,r));
            else
                dY2(y,r) = dY2s(y)*(1 - (Y2(y,r)).^2);
            end
        end

        for y = 1:hl
            dY1s(y) = 0;
            for x = 1:hl2
                dY1s(y) = dY1s(y) + dY2(x,r)*Wl(y,x);
            end
            if activ==1
                dY1(y,r) = dY1s(y)*Y1(y,r)*(1 - Y1(y,r));
            else
                dY1(y,r) = dY1s(y)*(1 - (Y1(y,r)).^2);
            end
        end
    end
end
