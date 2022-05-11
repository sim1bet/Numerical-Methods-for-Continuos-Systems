function [rhs] = ...
         Rhs_Man(n_nod, n_el, triang, coord, Areas, Bari, f1_man, f2_man, g_man, BLoc, CLoc, d, mx_el)
     
% Use of the mid_point rule
f1_N = zeros(n_nod,1);
f2_N = zeros(n_nod,1);
g = zeros(n_nod,1);
% Stabilization
g_s = zeros(n_nod,1);

%only for P1_bubble
f1_M = zeros(n_el,1);
f2_M = zeros(n_el,1);

for el=1:n_el
    % Baricenter coordinates
    x_br = Bari(el,1);
    y_br = Bari(el,2);
    
    % Basis coefficients for the stabilization components
    b_loc = BLoc(el,:);
    c_loc = CLoc(el,:);
    
    % Maximal Edge length for stabilization
    l = max_length(triang(el,:),coord);
    
    if mx_el == 2
        f1_M(el) = f1_man(x_br, y_br)*Areas(el)*9/20;
        f2_M(el) = f2_man(x_br, y_br)*Areas(el)*9/20;
    end
    
    for iloc=1:3
        iglob = triang(el,iloc);
        
        f1_N(iglob) = f1_N(iglob) + f1_man(x_br,y_br)*Areas(el)/3;
        f2_N(iglob) = f2_N(iglob) + f2_man(x_br,y_br)*Areas(el)/3;
        g(iglob)    = g(iglob) + g_man(x_br,y_br)*Areas(el)/3;
        if mx_el == 1
            % Stabilization
            g_s(iglob)  = g_s(iglob) - d*(l^2)/2*...
                          (b_loc(iloc)*f1_man(x_br,y_br) + c_loc(iloc)*f2_man(x_br,y_br));
        end
    end
end


if mx_el == 2
    rhs = [f1_N; f1_M; f2_N; f2_M; -g];
else
    rhs = [f1_N; f2_N; g_s-g];
end

end