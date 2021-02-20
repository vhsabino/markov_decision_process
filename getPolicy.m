function policy = getPolicy(T_up,T_down,T_right,T_left,value)
    policy = zeros(10,1);
    
    for i = 1:10
        v_up = T_up(i,:).*transpose(value);
        v_down = T_down(i,:).*transpose(value);
        v_left = T_left(i,:).*transpose(value);
        v_right = T_right(i,:).*transpose(value);
        
        [argvalue, argmax] = max([sum(v_up) sum(v_down) sum(v_left) sum(v_right)]);
        policy(i) =  argmax;
    end
    
    actions = ["UP", "DW", "LF", "RG"];
    
    debug = strings([3,4]);
    debug(1,:) = [actions(policy(3)) actions(policy(6)) actions(policy(9)) "+1"];
    debug(2,:) = [actions(policy(2)) actions(policy(5)) actions(policy(8)) "-1"];
    debug(3,:) = [actions(policy(1)) actions(policy(4)) actions(policy(7)) actions(policy(10))];
    disp(debug);
end