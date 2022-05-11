function [coord, triang, DirNod, DirVal, bndry, n_el, n_nodes]=input_data(meshdir)

%%% function extracting mesh information from the given directory meshdir
%%% see comments in main in case of discrepancies between the given url and
%%% the expected one

mesh_coord  = strcat(meshdir, '\xy.dat');
mesh_elem   = strcat(meshdir, '\mesh.dat');
mesh_DirNod = strcat(meshdir, '\dirnod.dat');
mesh_DirVal = strcat(meshdir, '\dirval.dat');
mesh_bound  = strcat(meshdir, '\contorno.dat');

coord  = load(mesh_coord);
triang = load(mesh_elem);
triang = triang(:,1:3);
DirNod = load(mesh_DirNod);
DirVal = load(mesh_DirVal);
bound  = importdata(mesh_bound);
bndry  = bound.data; 

n_el    = size(triang, 1);
n_nodes = size(coord, 1);

end