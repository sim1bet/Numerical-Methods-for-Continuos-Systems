function [S] = StabMat(n_el, n_nod, triang, coord, BLoc, CLoc, Areas, d)
% Construction of the stabilization matrix for the GLS stabilization

S = zeros(n_nod,n_nod);

for el=1:n_el
    b_loc = BLoc(el,:);
    c_loc = CLoc(el,:);
    
    l = max_length(triang(el,:), coord);
    for iloc=1:3
        iglob = triang(el,iloc);
        for jloc=1:3
            jglob = triang(el,jloc);
            
            S(iglob,jglob) = S(iglob,jglob) + ...
                             d*(l^2)*(b_loc(iloc)*b_loc(jloc)+c_loc(iloc)*c_loc(jloc))/(4*Areas(el));
            
        end
    end
end

S = sparse(S);

end