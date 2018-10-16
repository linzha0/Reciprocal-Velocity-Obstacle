function [ ang_a, v_Afinal ] = FindFinal(Pos_A, Goal_A, va )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

finalY=Goal_A(2)- Pos_A(2);
finalX=Goal_A(1)- Pos_A(1);
ang_a=atan2(finalY,finalX);

if ang_a <0
    ang_a= 2*pi +ang_a;
end

v_Afinal=[va*cos(ang_a),va*sin(ang_a)];

end

