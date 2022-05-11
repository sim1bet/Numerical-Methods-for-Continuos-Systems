function [H, A, B, S]=StiffMat(n_el, n_nodes, ALoc, BLoc, CLoc, D, v, triang, coord, Areas, tau)

%%%
% Construction of the stiffness matrix 
% Diffusive Term A
% Convective Term B
% SUP Term S
% H = A + B + S
%%%

A = sparse(n_nodes, n_nodes);
B = sparse(n_nodes, n_nodes);
S = sparse(n_nodes, n_nodes);

for el = 1:n_el
    l = max_length(triang(el, :), coord);
    for iloc = 1:3
        iglob = triang(el, iloc);
        for jloc = 1:3
            jglob = triang(el, jloc);
            % Diffusion matrix
            A(iglob, jglob) = A(iglob, jglob) + ...
                (D*(BLoc(el, iloc)*BLoc(el, jloc)+CLoc(el, iloc)*CLoc(el, jloc)))/(4*Areas(el));
            % Convective matrix
            B(iglob, jglob) = B(iglob, jglob) + ...
                (v(1)*BLoc(el, jloc)+v(2)*CLoc(el, jloc))/6;%*...
            % SUP matrix
            S(iglob, jglob) = S(iglob, jglob) + ...
                (D*l/norm(v))*tau/(8*Areas(el))*(v(1)*BLoc(el, iloc)+v(2)*CLoc(el, iloc))* ...
                (v(1)*BLoc(el, jloc)+v(2)*CLoc(el, jloc));
        end
    end
end

H = A + B + S;

end