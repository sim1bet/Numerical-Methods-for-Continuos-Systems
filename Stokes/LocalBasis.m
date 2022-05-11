function [ALoc, BLoc, CLoc, Areas, Areas_node, Bari]=LocalBasis(n_el, n_nod, triang, coord)

%%% Function definining the coefficients (a, b, c) of the P1 basis functions 
%%% at nodal points.
%%% N.b. If the linear system only considers the gradient of the basis
%%% functions, then coefficients (b, c) are sufficient.

ALoc = zeros(n_el,3);
BLoc = zeros(n_el,3);
CLoc = zeros(n_el,3);

Areas = zeros(n_el,1);
Areas_node = zeros(n_nod,1);
Bari = zeros(n_el,2);

% The coefficients of each element are defined as follows
% a_i = (x_j*y_k - x_k*y_j)/Area(el)
% b_i = (y_j - y_k)/Area(el)
% c_i = (x_k - x_j)/Area(el)

for el=1:n_el
    el_nodes = triang(el,:);
    % Areas of each element
    Area = det_el(el_nodes, coord);
    Areas(el) = abs(Area);
    
    % Baricenter of each element
    Bari(el,1) = ( coord(el_nodes(1),1) + coord(el_nodes(2),1) + coord(el_nodes(3),1) ) / 3;
    Bari(el,2) = ( coord(el_nodes(1),2) + coord(el_nodes(2),2) + coord(el_nodes(3),2) ) / 3;
    
    for nod=1:3
        n1=mod_n(nod+1,3);
        n2=mod_n(nod+2,3);
        
        n1_glob = el_nodes(n1);
        n2_glob = el_nodes(n2);
        
        ALoc(el,nod) = (coord(n1_glob,1)*coord(n2_glob,2) - coord(n1_glob,2)*coord(n2_glob,1));%/Area;
        BLoc(el,nod) = (coord(n1_glob,2) - coord(n2_glob,2));%/Area;
        CLoc(el,nod) = (coord(n2_glob,1) - coord(n1_glob,1));%/Area;
        
        Areas_node(el_nodes(nod)) = Areas_node(el_nodes(nod)) + Areas(el)/3;
    end
end

end