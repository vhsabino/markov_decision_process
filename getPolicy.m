function policy = getPolicy(T_up,T_down,T_right,T_left,value)
    policy = zeros(10,1);
    
    for i = 1:9
        v_up = T_up(i,:).*transpose(value);
        v_down = T_down(i,:).*transpose(value);
        v_left = T_left(i,:).*transpose(value);
        v_right = T_right(i,:).*transpose(value);
        
        if i == 1
            [argvalue, argmax] = max([sum(v_up) -9999 -9999 sum(v_right)]);
        elseif i == 2
            [argvalue, argmax] = max([sum(v_up) sum(v_down) -9999 sum(v_right)]);
        elseif i == 3
            [argvalue, argmax] = max([-9999 sum(v_down) -9999 sum(v_right)]);
        elseif i == 4
            [argvalue, argmax] = max([sum(v_up) -9999 sum(v_left) sum(v_right)]);
        elseif i == 5
            [argvalue, argmax] = max([sum(v_up) sum(v_down) sum(v_left) sum(v_right)]);
        elseif i == 6
            [argvalue, argmax] = max([-9999 sum(v_down) sum(v_left) sum(v_right)]);
        elseif i == 7
            [argvalue, argmax] = max([sum(v_up) -9999 sum(v_left) sum(v_right)]);
        elseif i == 8
            [argvalue, argmax] = max([sum(v_up) sum(v_down) sum(v_left) sum(v_right)]);
        %elseif i == 9
        else
            [argvalue, argmax] = max([-9999 sum(v_down) sum(v_left) sum(v_right)]);
        %else
        %    [argvalue, argmax] = max([sum(v_up) -9999 sum(v_left) -9999]);
        end
        policy(i) =  argmax;
    end
    
    actions = ["UP", "DW", "LF", "RG"];
    
    debug = strings([3,4]);
    debug(1,:) = [actions(policy(3)) actions(policy(6)) actions(policy(9)) "+1"];
    debug(2,:) = [actions(policy(2)) actions(policy(5)) actions(policy(8)) "-1"];
    debug(3,:) = [actions(policy(1)) actions(policy(4)) actions(policy(7)) "0.2"];
    disp(debug);
end