%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Main for the solution of a convection-diffusion problem
%%% Author: Betteti Simone
%%% Date: 12/08/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Use of a 2D mesh taken from the directory
%%% dir: D:\University\Mathematical Engineering\First year\Second
%%% Semester\Numerical Methods For Continuous Systems\Projects\mesh

clear all; close all; clc;

% See link above in "dir" to get the correct directory
meshdir = "D:\University\Mathematical Engineering\First year\Second Semester\Numerical Methods For Continuous Systems\Projects\mesh";
[coord, triang, DirNod, DirVal, bndry, n_el, n_nodes] = input_data(meshdir);

v = [1, 3];
D = [0.001, 0.01, 0.05, 0.1, 0.5, 1];
D_thr = [0.07, 0.071, 0.072, 0.073,0.074, 0.075];

% Construction of the linear local basis \phi_i(x,y)= a_i + b_i*x + c_i*y
[ALoc, BLoc, CLoc, Areas] = LocalBasis(n_el, triang, coord);

% The defined tau must be positive
tau = 100;

%%%%%%%%
% If BC == 0 --> penalty approach for BC
% If BC == 1 --> uplift boundary operator for BC
BC = 1;
balance = zeros(length(D),1);

for k=1:length(D)
    % Construction of the stiffness matrix
    [H, A, B, S] = StiffMat(n_el, n_nodes, ALoc, BLoc, CLoc, D(k), v, triang, coord, Areas, tau);
    [H_d, rhs] = DirH(H, DirNod, DirVal, BC);
    % Use of GMRES to solve the inverse problem
    [u_num] = solver(H_d, rhs);
    % Plotting of the solution according to the given mesh
    mesh_vid(u_num, k, triang, coord);
    balance(k,1) = mass_balance(u_num, H, DirNod, coord, v);
end
balance
