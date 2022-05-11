function [coord, triang, DirNod, DirVal, u1_man, u2_man, p_man, f1_man, f2_man, n_el, n_nod]...
          =input_data(meshdir, inp, mesh, c, mu, mx_el)
% function extracting relevant information according to the given meshes
% and computing boundary conditions on the basis of inp value, along with
% other relevant and type specific components

n = num2str(mesh);
fin_meshdir = append(meshdir,'\mesh',n);

mesh_coord = append(fin_meshdir,'\coord.dat');
mesh_triang = append(fin_meshdir,'\triang.dat');
mesh_DirNod = append(fin_meshdir,'\dirnod.dat');
%mesh_DirVal = append(fin_meshdir,'\dirVal.dat');

coord = load(mesh_coord);
triang = load(mesh_triang);
DirNod = load(mesh_DirNod);

n_el = size(triang,1);
n_nod = size(coord,1);

if mx_el == 2
    DirVal.u1 = zeros(n_nod+n_el,1);
    DirVal.u2 = zeros(n_nod+n_el,1);
    DirVal.p = zeros(n_nod+n_el,1); 
else
    DirVal.u1 = zeros(n_nod,1);
    DirVal.u2 = zeros(n_nod,1);
    DirVal.p = zeros(n_nod,1); 
end


if inp==0
    % manufactured solutions
    u1_man = @(x,y) -cos(2*pi*x)*sin(2*pi*y) + sin(2*pi*y);
    u2_man = @(x,y) sin(2*pi*x)*cos(2*pi*y) - sin(2*pi*x);
    p_man = @(x,y) 2*pi*(cos(2*pi*y)-cos(2*pi*x));
    % forcing terms
    f1_man = @(x,y) c*u1_man(x,y)-4*mu*(pi^2)*sin(2*pi*y)*(2*cos(2*pi*x)-1)+4*(pi^2)*sin(2*pi*x);
    f2_man = @(x,y) c*u2_man(x,y)+4*mu*(pi^2)*sin(2*pi*x)*(2*cos(2*pi*y)-1)-4*(pi^2)*sin(2*pi*y);
    
    % computation of boundary values
    %DirVal = load(mesh_DirVal);
    for node=1:length(DirNod)
         DirVal.u1(DirNod(node)) = u1_man(coord(DirNod(node),1),coord(DirNod(node),2));
         DirVal.u2(DirNod(node)) = u2_man(coord(DirNod(node),1),coord(DirNod(node),2));
         DirVal.p(DirNod(node)) = p_man(coord(DirNod(node),1),coord(DirNod(node),2));
    end
elseif inp==1
    u1_man = @(x,y) 0;
    u2_man = @(x,y) 0;
    p_man = @(x,y) 0;
    f1_man = @(x,y) 0;
    f2_man = @(x,y) 0;
    for node=1:length(coord(:,1))
        if coord(node,2) == 1
            DirVal.u1(node) = 1;
        end
    end
end

end