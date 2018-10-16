function [ getgoal ] = Getgoal( Pos_A,Goal_A )

GOALX=Goal_A(1)- Pos_A(1);
GOALY=Goal_A(2)- Pos_A(2);

distance= sqrt(GOALX^2+GOALY^2);

if  (distance >= 0) && (distance < 3)
    
    getgoal = 1;
else
    getgoal = 0;
end

end

