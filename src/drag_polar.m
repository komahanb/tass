function [k1, cd0] = drag_polar(h,dT,v_fts)

 [~,a,~,~,~,~] = stdatmo(h,dT,'US');
 
 M = v_fts/a;

 if (M <= 0.8) 
  
     k1  = 0.14;
     cd0 = 0.018;
  
 elseif (M > 0.8 && M <= 1.2) 
    
     
     x   = [0.8,1.2]';
     y   = [0.14,0.20]';
     k1  = interp1q(x,y,M);
     
     x   = [0.8,1.2]';
     y   = [0.018,0.040]';
     cd0 = interp1q(x,y,M);
 
 else
     
     
     x  = [1.2, 2.0]';
     y  = [0.20,0.50]';
     k1 = interp1q(x,y,M); 
     
     x  = [1.2, 2.0]';
     y  = [0.040,0.038]';
     cd0 = interp1q(x,y,M); 
    
 end
  
end