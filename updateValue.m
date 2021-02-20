function value = updateValue(T_up,T_down,T_right,T_left,rw,value,k)
    value_aux=zeros(12,1);
    for i=1:12
        v_up = T_up(i,:).*transpose(value);
        v_down = T_down(i,:).*transpose(value);
        v_left = T_left(i,:).*transpose(value);
        v_right = T_right(i,:).*transpose(value);
        value_aux(i) = rw(i) + max([sum(v_up) sum(v_down) sum(v_left) sum(v_right)]);
    end
    
    value = value_aux;
    
    fprintf("Iteration: %d\n",k);
    debug = zeros(3,4);
    debug(1,:) = [value(3) value(6) value(9) value(12)];
    debug(2,:) = [value(2) value(5) value(8) value(11)];
    debug(3,:) = [value(1) value(4) value(7) value(10)];
    disp(debug);
end