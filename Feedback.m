function [ Result,alpha, beta, gamma ] =  Feedback( Pos_A, Pos_B, r_A, r_B, v_Afinal, v_B)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
ag2=v_Afinal(2)-v_B(2);
ag1=v_Afinal(1)-v_B(1);

gamma=atan2(ag2,ag1);
if gamma < 0
    gamma=2*pi+gamma;% the angle of v_A -v_B
end

VOY=Pos_B(2)- Pos_A(2);
VOX=Pos_B(1)- Pos_A(1);

alpha=atan2(VOY,VOX);
if alpha < 0
    alpha= 2*pi+alpha; % the angle between agent connection line and X axis
end

d=sqrt(VOX^2+VOY^2);

if  d== r_B+r_B
    if alpha >= 0 && alpha < pi/2
        if (gamma >=0 && gamma < alpha+pi/2) || (gamma > alpha+3*pi/2 && gamma <2*pi)
          Result=1;
        else
          Result=0;
        end
    
    elseif alpha >=pi/2 && alpha < (3*pi/2)
        if gamma >alpha-pi/2 && gamma <alpha +pi/2
          Result =1;
        else
          Result=0;
        end
    else
        if (gamma>alpha- pi/2 && gamma <=2*pi) || (gamma >=0 && gamma <alpha-3*pi/2)
          Result=1;
        else
          Result=0;
        end
    end

else
    beta=asin((r_A+r_B)/d);
    
    if (alpha-beta) <0
       if (gamma >= 0 && gamma < (alpha+beta)) || (gamma > (alpha-beta +2*pi) && gamma <= 2*pi)
           Result =1;
       else
           Result=0;
       end
    elseif (alpha+beta)> (2*pi)
        if (gamma >= 0 && gamma < (alpha+beta-2*pi)) || (gamma > (alpha-beta) && gamma <= 2*pi)
            Result =1;
        else
            Result=0;
        end
    else
        if gamma > alpha-beta && gamma < alpha+beta
           Result=1;
        else
           Result=0;
        end 
    end
end



end

