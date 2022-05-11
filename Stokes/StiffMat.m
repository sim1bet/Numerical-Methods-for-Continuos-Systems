function [A] = StiffMat(n_el, n_nod, triang, BLoc, CLoc, Areas, cst, mu, mx_el)

% function for the construction of the different components of the
% stiffness matrix and assembly according to the chosen basis

% Mass Matrices
Mass_NN = zeros(n_nod, n_nod);
% Only for P1_bubble
Mass_NM = zeros(n_nod, n_el);
Mass_MM = zeros(n_el, n_el);

% Diffusion Matrices
Diff_NN = zeros(n_nod, n_nod);
% Only for P1_bubble
Diff_MM = zeros(n_el, n_el);

for el = 1:n_el
    
    b_loc = BLoc(el,:);
    c_loc = CLoc(el,:);
    
    if mx_el == 2
        Mass_MM(el,el) = Mass_MM(el,el) + Areas(el)*81/280; 
        Diff_MM(el,el) = Diff_MM(el,el) + (b_loc(1)^2 + b_loc(2)^2 + ...
                                          c_loc(1)^2 + c_loc(2)^2 + ...
                                          b_loc(1)*b_loc(2)+c_loc(1)*c_loc(2))*...
                                          81/(40*Areas(el));                            
    end
    for iloc = 1:3
        iglob = triang(el, iloc);
        
        if mx_el == 2
            Mass_NM(iglob,el) = Mass_NM(iglob,el) + Areas(el)*3/20; 
        end
        for jloc = 1:3
            jglob = triang(el, jloc);
            
            Mass_NN(iglob,jglob) = Mass_NN(iglob,jglob) + ...
                                   (1+eq(iglob,jglob))*Areas(el)/12;
            
            Diff_NN(iglob,jglob) = Diff_NN(iglob,jglob) + ...
                                   (b_loc(iloc)*b_loc(jloc)+c_loc(iloc)*c_loc(jloc))/(4*Areas(el));
        end
    end
end


if mx_el == 2
    A = [mu*Diff_NN + cst*Mass_NN, cst*Mass_NM;
         cst*Mass_NM', mu*Diff_MM + cst*Mass_MM];
else
    A = [mu*Diff_NN + cst*Mass_NN, zeros(n_nod,n_nod);
         zeros(n_nod,n_nod), mu*Diff_NN + cst*Mass_NN];
end

A = sparse(A); 

end