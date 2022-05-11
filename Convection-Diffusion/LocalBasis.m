function [ALoc, BLoc, CLoc, Areas]=LocalBasis(n_el, triang, coord)

%%% Function definining the coefficients (a, b, c) of the P1 basis functions 
%%% at nodal points.
%%% N.b. If the linear system only considers the gradient of the basis
%%% functions, then coefficients (b, c) are sufficient.

ALoc = zeros(n_el,3);
BLoc = zeros(n_el,3);
CLoc = zeros(n_el,3);

Areas = zeros(n_el);

% The coefficients of each element are defined as follows
% a_i = (x_j*y_k - x_k*y_j)/Area(el)
% b_i = (y_j - y_k)/Area(el)
% c_i = (x_k - x_j)/Area(el)

for el=1:n_el
    el_nodes = triang(el,:);
    Area = det_el(el_nodes, coord);
    Areas(el) = abs(Area);
    for nod=1:3
        n1=mod_n(nod+1,3);
        n2=mod_n(nod+2,3);
        
        n1_glob = el_nodes(n1);
        n2_glob = el_nodes(n2);
        
        ALoc(el,nod) = (coord(n1_glob,1)*coord(n2_glob,2) - coord(n1_glob,2)*coord(n2_glob,1));%/Area;
        BLoc(el,nod) = (coord(n1_glob,2) - coord(n2_glob,2));%/Area;
        CLoc(el,nod) = (coord(n2_glob,1) - coord(n1_glob,1));%/Area;
        
    end
end

end