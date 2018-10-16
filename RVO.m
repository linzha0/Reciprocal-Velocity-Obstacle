
clc;clear;close all
format compact

global tol  va r_A r_B vb ang_B  


i=1;
t=0.1;
tol=0.0001;
% agent
Pos_A=[10,162];
Goal=[80,162;40,120;90,90];
va=30;  
r_A=3;


% Obstacles
Pos_B=[70,190];
vb=30; 
r_B=3;
ang_B=[5*pi/4;0;3*pi/2];

xa(i)=Pos_A(1);
ya(i)=Pos_A(2);
xb(i)=Pos_B(1);
yb(i)=Pos_B(2);
%start

inter=size(Goal,1);

for n=1:1:inter
    
 v_B=[vb*cos(ang_B(n,1)),vb*sin(ang_B(n,1))];

Goal_A(1)=Goal(n,1);
Goal_A(2)=Goal(n,2);

[ ang_A, v_Abest] = FindBestVel( Pos_A, Goal_A, va );
[ result,Alpha,Beta,Gamma ] = FindVO( Pos_A, Pos_B, r_A, r_B, v_Abest, v_B);
[ getgoal ] = Getgoal( Pos_A,Goal_A );


if result == 0
   
       while getgoal == 0
           
          v_A(1,i)=v_Abest(1);
          v_A(2,i)=v_Abest(2);
          [ Pos1, Pos2 ] = simulation( Pos_A,Pos_B, v_A(:,i),v_B,t);
          Pos_A=Pos1;
          Pos_B=Pos2;
          i=i+1;
          xa(i)=Pos_A(1);
          ya(i)=Pos_A(2);
          xb(i)=Pos_B(1);
          yb(i)=Pos_B(2);
            
          [ getgoal ] = Getgoal( Pos_A,Goal_A );
          
        end
else
   while true 
    d1=sqrt((xa(i)-xb(i))^2+(ya(i)-yb(i))^2);
    
    v_A(1,i)=v_Abest(1);
    v_A(2,i)=v_Abest(2);
    [ Pos1, Pos2 ] = simulation( Pos_A,Pos_B, v_A(:,i),v_B,t);
    Pos_A=Pos1;
    Pos_B=Pos2;
    i=i+1;
    xa(i)=Pos_A(1);
    ya(i)=Pos_A(2);
    xb(i)=Pos_B(1);
    yb(i)=Pos_B(2);
    d2=sqrt((xa(i)-xb(i))^2+(ya(i)-yb(i))^2);
    
    if (d1 > 3*r_A+r_B) && (d2 <= 3*r_A+r_B)
        count=1;
        
        if count ==1
            break
        end
    end
    
   end

    Pos_A(1)=xa(i-1);
    Pos_A(2)=ya(i-1);
    Pos_B(1)=xb(i-1);
    Pos_B(2)=yb(i-1);
    i=i-1;
    
    [ result,Alpha,Beta,Gamma ] = FindVO( Pos_A, Pos_B, r_A, r_B, v_Abest, v_B);
    [ true1, true2 ] = choosevel( Pos_A,Alpha,Beta,v_B ,va,ang_A);
     
    while true
        
          v_A(1,i)= true1;
          v_A(2,i)= true2;     
          [ Pos1, Pos2 ] = simulation( Pos_A,Pos_B, v_A(:,i), v_B,t);
          Pos_A=Pos1;
          Pos_B=Pos2;
          
          i=i+1;
          xa(i)=Pos_A(1);
          ya(i)=Pos_A(2);
          xb(i)=Pos_B(1);
          yb(i)=Pos_B(2);
          
          [ ang_a, v_Afinal ] = FindFinal(Pos_A, Goal_A, va );
           
          [ Result ] =  Feedback( Pos_A, Pos_B, r_A, r_B, v_Afinal, v_B);
          
          if Result == 0
             
             while 1
                 
                v_A(1,i)=v_Afinal(1);
                v_A(2,i)=v_Afinal(2); 
                [ Pos1, Pos2 ] = simulation( Pos_A,Pos_B, v_A(:,i),v_B,t);
             
                Pos_A=Pos1;
                Pos_B=Pos2;
                i=i+1;
                xa(i)=Pos_A(1);
                ya(i)=Pos_A(2);
                xb(i)=Pos_B(1);
                yb(i)=Pos_B(2);
                
                [ getgoal ] = Getgoal( Pos_A,Goal_A );
                if getgoal ==1
                    break
                end
                
          
             end
             
          end
          if getgoal == 1
              break
          end
          
    end
    
end

end
        
h=figure('numbertitle','off','name','Moving-obstacles-avoidance');
plot([0,150],[0,200],'.');
hold on

text (5,180,'Obstacle','color','b')
text (5,175,'Agent','color','r')
plot(Goal(1:n,1),Goal(1:n,2),'r*');
xlabel('cm','fontsize',12)
ylabel('cm','fontsize',12)

a=0:pi/20:2*pi;
b=0:pi/20:2*pi;

for j=1:i
    
    Xa=r_A*cos(a)+xa(j);
    Ya=r_A*sin(a)+ya(j);
    
    Xb=r_B*cos(b)+xb(j);
    Yb=r_B*sin(b)+yb(j);
    
    if ~ishandle(h),return,end
    plot(Xa,Ya,'r-')
    plot(Xb,Yb,'b-')
    axis equal
    drawnow;
    mov(j)=getframe;
    pause(0.1)
end
 movie2avi(mov,'Obstacle-Avoidance.avi','compression','none','fps',10);



 
        
        
        
        
        
    
    

















 
 
 


