function [Div_NN_B, Div_NN_C, Div_NM_B, Div_NM_C] = DivMat(n_el, n_nod, triang, BLoc, CLoc, mx_el)
% Construction of the divergence matrices associated with the b( , )
% funcitonal
Div_NN_B = zeros(n_nod,n_nod);
Div_NN_C = zeros(n_nod,n_nod);
% Only for P1_bubble
Div_NM_B = zeros(n_nod,n_el);
Div_NM_C = zeros(n_nod,n_el);

for el=1:n_el
    
    b_loc = BLoc(el,:);
    c_loc = CLoc(el,:);
    
    for iloc=1:3
        iglob = triang(el,iloc);
        if mx_el == 2
            Div_NM_B(iglob,el) = Div_NM_B(iglob,el) + b_loc(iloc)*9/40;
            Div_NM_C(iglob,el) = Div_NM_C(iglob,el) + c_loc(iloc)*9/40;
        end
        for jloc=1:3
            jglob = triang(el,jloc);
            
            Div_NN_B(iglob,jglob) = Div_NN_B(iglob,jglob) - b_loc(jloc)/6;
            Div_NN_C(iglob,jglob) = Div_NN_C(iglob,jglob) - c_loc(jloc)/6;
        end
    end
end

Div_NN_B = sparse(Div_NN_B);
Div_NN_C = sparse(Div_NN_C);

Div_NM_B = sparse(Div_NM_B);
Div_NM_C = sparse(Div_NM_C);

end