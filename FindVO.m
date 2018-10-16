function [ result,Alpha,Beta,Gamma ] = FindVO( Pos_A, Pos_B, r_A, r_B, v_Abest, v_B)
% This function is used for judging the uav will have a collsion or not


ag2=v_Abest(2)-v_B(2);
ag1=v_Abest(1)-v_B(1);

Gamma=atan2(ag2,ag1);
if Gamma < 0
    Gamma=2*pi+Gamma;% the angle of v_A -v_B
end

VOY=Pos_B(2)- Pos_A(2);
VOX=Pos_B(1)- Pos_A(1);

Alpha=atan2(VOY,VOX);
if Alpha < 0
    Alpha= 2*pi+Alpha; % the angle between agent connection line and X axis
end

d=sqrt(VOX^2+VOY^2);

if  d== r_B+r_B
    if Alpha >= 0 && Alpha < pi/2
        if (Gamma >=0 && Gamma < Alpha+pi/2) || (Gamma > Alpha+3*pi/2 && Gamma <2*pi)
          result=1;
        else
          result=0;
        end
    
    elseif Alpha >=pi/2 && Alpha < (3*pi/2)
        if Gamma >Alpha-pi/2 && Gamma <Alpha +pi/2
          result =1;
        else
          result=0;
        end
    else
        if (Gamma>Alpha- pi/2 && Gamma <=2*pi) || (Gamma >=0 && Gamma <Alpha-3*pi/2)
          result=1;
        else
          result=0;
        end
    end

else
    Beta=asin((r_A+r_B)/d);
    
    if (Alpha-Beta) <0
       if (Gamma >= 0 && Gamma < (Alpha+Beta)) || (Gamma > (Alpha-Beta +2*pi) && Gamma <= 2*pi)
           result =1;
       else
           result=0;
       end
    elseif (Alpha+Beta)> (2*pi)
        if (Gamma >= 0 && Gamma < (Alpha+Beta-2*pi)) || (Gamma > (Alpha-Beta) && Gamma <= 2*pi)
            result =1;
        else
            result=0;
        end
    else
        if Gamma > Alpha-Beta && Gamma < Alpha+Beta
           result=1;
        else
           result=0;
        end 
    end
end


end

