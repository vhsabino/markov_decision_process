clc
clear all
close all

width=4;
height=3;
iterations = 1000;
epsilon = 1e-3;
Ra = -0.004;
rw = ones(12,1)*Ra;
rw(5,1) = -0.5;
rw(10,1) = 0.2;
rw(11,1) = -1;
rw(12,1) = 1;

T_up = zeros(12,12);
T_down = zeros(12,12);
T_left = zeros(12,12);
T_right = zeros(12,12);

%% T_UP

T_up(1,2) = 0.8;
T_up(1,4) = 0.1;
T_up(1,1) = 0.1;

T_up(2,3) = 0.8;
T_up(2,2) = 0.1;
T_up(2,5) = 0.1;

T_up(3,3) = 0.9;
T_up(3,6) = 0.1;

T_up(4,5) = 0.8;
T_up(4,7) = 0.1;
T_up(4,1) = 0.1;

T_up(5,6) = 0.8;
T_up(5,2) = 0.1;
T_up(5,8) = 0.1; 

T_up(6,6) = 0.8;
T_up(6,9) = 0.1;
T_up(6,3) = 0.1;

T_up(7,8) = 0.8; 
T_up(7,10) = 0.1;
T_up(7,4) = 0.1; 

T_up(8,9) = 0.8;
T_up(8,11) = 0.1;
T_up(8,5) = 0.1;

T_up(9,9) = 0.8; 
T_up(9,12) = 0.1;
T_up(9,6) = 0.1;

%T_up(10,11) = 0.8;
%T_up(10,10) = 0.1;
%T_up(10,7) = 0.1;

%% T_DOWN

T_down(1,1) = 0.9;
T_down(1,4) = 0.1;

T_down(2,1) = 0.8;
T_down(2,2) = 0.1;
T_down(2,5) = 0.1;

T_down(3,2) = 0.8;
T_down(3,3) = 0.1;
T_down(3,6) = 0.1;

T_down(4,4) = 0.8;
T_down(4,7) = 0.1;
T_down(4,1) = 0.1;

T_down(5,4) = 0.8;
T_down(5,2) = 0.1;
T_down(5,8) = 0.1; 

T_down(6,5) = 0.8;
T_down(6,9) = 0.1;
T_down(6,3) = 0.1;

T_down(7,7) = 0.8; 
T_down(7,10) = 0.1;
T_down(7,4) = 0.1; 

T_down(8,7) = 0.8;
T_down(8,11) = 0.1;
T_down(8,5) = 0.1;

T_down(9,5) = 0.8; 
T_down(9,12) = 0.1;
T_down(9,6) = 0.1;

%T_down(10,10) = 0.9;
%T_down(10,7) = 0.1;

%% T_LEFT

T_left(1,1) = 0.9;
T_left(1,2) = 0.1;

T_left(2,2) = 0.8;
T_left(2,3) = 0.1;
T_left(2,1) = 0.1;

T_left(3,3) = 0.9;
T_left(3,2) = 0.1;

T_left(4,1) = 0.8;
T_left(4,4) = 0.1;
T_left(4,5) = 0.1;

T_left(5,2) = 0.8;
T_left(5,4) = 0.1;
T_left(5,6) = 0.1; 

T_left(6,3) = 0.8;
T_left(6,6) = 0.1;
T_left(6,5) = 0.1;

T_left(7,4) = 0.8; 
T_left(7,7) = 0.1;
T_left(7,8) = 0.1; 

T_left(8,5) = 0.8;
T_left(8,7) = 0.1;
T_left(8,9) = 0.1;

T_left(9,6) = 0.8; 
T_left(9,9) = 0.1;
T_left(9,8) = 0.1;

%T_left(10,7) = 0.8;
%T_left(10,10) = 0.1;
%T_left(10,11) = 0.1;

%% T_RIGHT

T_right(1,4) = 0.8;
T_right(1,2) = 0.1;
T_right(1,1) = 0.1;

T_right(2,5) = 0.8;
T_right(2,1) = 0.1;
T_right(2,3) = 0.1;

T_right(3,6) = 0.8;
T_right(3,3) = 0.1;
T_right(3,2) = 0.1;

T_right(4,7) = 0.8;
T_right(4,4) = 0.1;
T_right(4,5) = 0.1;

T_right(5,5) = 0.8;
T_right(5,4) = 0.1;
T_right(5,6) = 0.1; 

T_right(6,9) = 0.8;
T_right(6,6) = 0.1;
T_right(6,5) = 0.1;

T_right(7,10) = 0.8; 
T_right(7,7) = 0.1;
T_right(7,8) = 0.1; 

T_right(8,11) = 0.8;
T_right(8,7) = 0.1;
T_right(8,9) = 0.1;

T_right(9,12) = 0.8; 
T_right(9,9) = 0.1;
T_right(9,8) = 0.1;

%T_right(10,10) = 0.9;
%T_right(10,11) = 0.1;

value = zeros(12,1);

for i = 1:iterations
    old_value = value;
    value = updateValue(T_up,T_down,T_right,T_left,rw,value,i);
    diff = sum(value - old_value);
    if abs(diff) < epsilon
       disp("Converged");
       break;
    end
end

policyPrime = getPolicy(T_up,T_down,T_right,T_left,value);