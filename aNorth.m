function uValue = aNorth(xval,yval,Ymax,U,POINTS,k)

% can't go north if at YMax or if in cell below sink 'because it will go to sink cell'
if (yval>=Ymax)
    uValue=U(k);
else
    for h=1:size(POINTS,1)
        if (POINTS(h,1)==xval && POINTS(h,2)==yval+1)
            row=h;
        end
    end
    
    uValue=U(row);
end


end

