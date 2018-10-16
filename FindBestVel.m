function [ ang_A, v_Abest] = FindBestVel( Pos_A, Goal_A, va )
% This funcation is used finging the best velocity for agent A to get goal


bestY=Goal_A(2)- Pos_A(2);
bestX=Goal_A(1)- Pos_A(1);
ang_A=atan2(bestY,bestX);

if ang_A <0
    ang_A= 2*pi +ang_A;
end

v_Abest=[va*cos(ang_A),va*sin(ang_A)];

end

