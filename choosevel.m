function [ true1, true2 ] = choosevel( Pos_A,Alpha,Beta,v_B ,va,ang_A)
%[X,Y] is the point in the line of "Alpha+Beta"
%[x,y] is the point in the line of "Alpha-Beta"
global tol

  
V_b=[v_B(1)+Pos_A(1),v_B(2)+Pos_A(2)];

k1=tan(Alpha+Beta);
a1=1+k1^2;
b1=-2*Pos_A(1)+2*k1*(-k1*V_b(1)+V_b(2)-Pos_A(2));
c1=Pos_A(1)^2+(-k1*V_b(1)+V_b(2)-Pos_A(2))^2-va^2;

k2=tan(Alpha-Beta);
a2=1+k2^2;
b2=-2*Pos_A(1)+2*k2*(-k2*V_b(1)+V_b(2)-Pos_A(2));
c2=Pos_A(1)^2+(-k2*V_b(1)+V_b(2)-Pos_A(2))^2-va^2;

delta1=b1^2-4*a1*c1;
delta2=b2^2-4*a2*c2;

X1=(-b1+sqrt(delta1))/(2*a1);
Y1=k1*(X1-V_b(1))+V_b(2); 
V1x=X1-Pos_A(1);
V1y=Y1-Pos_A(2);
X2=(-b1-sqrt(delta1))/(2*a1);
Y2=k1*(X2-V_b(1))+V_b(2);
V2x=X2-Pos_A(1);
V2y=Y2-Pos_A(2);
  
x1=(-b2+sqrt(delta2))/(2*a2);
y1=k2*(x1-V_b(1))+V_b(2);
v1x=x1-Pos_A(1);
v1y=y1-Pos_A(2);
x2=(-b2-sqrt(delta2))/(2*a2);
y2=k2*(x2-V_b(1))+V_b(2);
v2x=x2-Pos_A(1);
v2y=y2-Pos_A(2);




A=(Y1-V_b(2))/(sqrt((X1-V_b(1))^2+(Y1-V_b(2))^2));
B=(Y2-V_b(2))/(sqrt((X2-V_b(1))^2+(Y2-V_b(2))^2));
C=(y1-V_b(2))/(sqrt((x1-V_b(1))^2+(y1-V_b(2))^2));
D=(y2-V_b(2))/(sqrt((x2-V_b(1))^2+(y2-V_b(2))^2));

if (delta1 == 0) && (delta2 == 0)% both line have one solution
    
    if abs(A-sin(Alpha+Beta))<= tol && abs(C+sin(Alpha-Beta))<= tol
      true1=V1x;
      true2=V1y;
   elseif abs(A+sin(Alpha+Beta))<= tol && abs(C-sin(Alpha-Beta))<= tol
      true1=v1x;
      true2=v1y;
   else 
         Bet=atan2(V1y,V1x);  
         if Bet < 0
             Bet =2*pi+Bet;
         end
         
         Del=atan2(v1y,v1x);
         if Del < 0;
             Del =2*pi+Del;
         end
         
         ang1=abs(ang_A-Bet);
         ang3=abs(ang_A-Del); 
         if ang1 > ang3
            true1=v1x;
            true2=v1y; 
         else
            true1=V1x;
            true2=V1y;
         end
   end
    
elseif ((delta1 > 0) && (delta2 < 0)) || ((delta1 > 0) && (delta2 == 0))
    
   if abs(A-sin(Alpha+Beta)) <= tol && abs(B+sin(Alpha+Beta)) <= tol
      true1=X1;
      true2=Y1;
   elseif abs(A+sin(Alpha+Beta)) <= tol && abs(B-sin(Alpha+Beta)) <= tol
      true1=X2;
      true2=Y2;
   else
         Bet=atan2(V1y,V1x);  
         if Bet < 0
             Bet =2*pi+Bet;
         end
         
         Gam=atan2(V2y,V2x);
         if Gam < 0
             Gam = 2*pi+Gam;
         end
         
         ang1=abs(ang_A-Bet);
         ang2=abs(ang_A-Gam); 
         if ang1 > ang2
            true1=V2x;
            true2=V2y; 
         else
            true1=V1x;
            true2=V1y;
         end
   end
     
elseif ((delta1 < 0) && (delta2 > 0)) || ((delta1 == 0) && (delta2 > 0))
    
   if abs(C-sin(Alpha-Beta)) <= tol && abs(D+sin(Alpha-Beta)) <= tol
      true1=v1x;
      true2=v1y;
   elseif abs(C+sin(Alpha-Beta)) <= tol && abs(D - sin(Alpha-Beta))<=tol
      true1=v2x;
      true2=v2y;
   else 
         Del=atan2(v1y,v1x);
         if Del < 0;
             Del =2*pi+Del;
         end
         Eps=atan2(v2y,v2x);
         if Eps < 0;
             Eps =2*pi+Eps;
         end
         ang3=abs(ang_A-Del);
         ang4=abs(ang_A-Eps); 
         if ang3 > ang4
            true1=v2x;
            true2=v2y; 
         else
            true1=v1x;
            true2=v1y;
         end
   end
   
           
elseif delta1>0 && delta2 >0 %four solustions
    
         
         Bet=atan2(V1y,V1x);  
         if Bet < 0
             Bet =2*pi+Bet;
         end
         Gam=atan2(V2y,V2x);
         if Gam < 0
             Gam = 2*pi+Gam;
         end
         Del=atan2(v1y,v1x);
         if Del < 0;
             Del =2*pi+Del;
         end
         Eps=atan2(v2y,v2x);
         if Eps < 0;
             Eps =2*pi+Eps;
         end
         ang1=abs(ang_A-Bet);
         ang2=abs(ang_A-Gam);  
         ang3=abs(ang_A-Del);  
         ang4=abs(ang_A-Eps); 
         if ang1 > ang2
             TRUE1=V2x;
             TRUE2=V2y;
         else 
             TRUE1=V1x;
             TRUE2=V1y;
         end
         if ang3 > ang4
             True1=v2x;
             True2=v2y;
         else
             True1=v1x;
             True2=v1y;
         end
         
         Zat=atan2(TRUE2,TRUE1);
         if Zat <0
             Zat = 2*pi+Zat;
         end
         Eit=atan2(True2,True1);
         if Eit <0
             Eit =2*pi+Eit;
         end
         ang5=abs(ang_A-Zat);
         ang6=abs(ang_A-Eit); 
         if ang6 > ang5
             true1=TRUE1;
             true2=TRUE2;
         else
             true1=True1;
             true2=True2;
         end
%     end
end

         
         
   
    
    
        
          
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    





