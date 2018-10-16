function [ Pos1, Pos2 ] = simulation( Pos_A,Pos_B, v_A,v_B,t)

simX1=Pos_A(1)+v_A(1)*t;
simY1=Pos_A(2)+v_A(2)*t;
Pos1=[simX1,simY1];

simX2=Pos_B(1)+v_B(1)*t;
simY2=Pos_B(2)+v_B(2)*t;
Pos2=[simX2,simY2];
end

