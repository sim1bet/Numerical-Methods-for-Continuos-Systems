%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Main for the solution of a Stokes problem
%%% Author: Betteti Simone
%%% Date: 04/09/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% It will provide instructions on how to implement the different types of
% elements, as well as the manufactured solution approach and the
% Lid-driven approach

clear all; close all; clc;

meshdir = "D:\University\Mathematical Engineering\First year\Second Semester\Numerical Methods For Continuous Systems\Projects\Project II\meshes";
t = 1;
mu = 1;
d = 0.01;
% inverse time step c = (t)^(-1);
c = (t)^(-1);

% inp = {'manufactured'=0,'lid-driven'=1}
inp = 0;
% mesh = {0, 1, 2, 3, 4}
mesh = 4;
% Types of mixed elements mx_el = {'P1-P1'=0, 'GLS'=1, 'P1_bubble-P1'=2}
mx_el = 2;

% definition of the relevant input quantities
[coord, triang, DirNod, DirVal, u1_man, u2_man, p_man, f1_man, f2_man, n_el, n_nod] ...
 = input_data(meshdir, inp, mesh, c, mu, mx_el);

% Construction of the local basis
[ALoc, BLoc, CLoc, Areas, Areas_node, Bari] = LocalBasis(n_el, n_nod, triang, coord);

% Construction of the Stiffness Matrix and Divergence Matrix 
A = StiffMat(n_el, n_nod, triang, BLoc, CLoc, Areas, c, mu, mx_el);
[Div_NN_B, Div_NN_C, Div_NM_B, Div_NM_C ] = DivMat(n_el, n_nod, triang, BLoc, CLoc, mx_el);
if mx_el == 1
    S = StabMat(n_el, n_nod, triang, coord, BLoc, CLoc, Areas, d);
else
    S = zeros(n_nod, n_nod);
end

% Assembly of the final matrix
H = Assemble(A, S, Div_NN_B, Div_NN_C, Div_NM_B, Div_NM_C, mx_el, n_nod);

% Construction of the rhs
g_man = @(x,y) 0;
[rhs] = Rhs_Man(n_nod, n_el, triang, coord, Areas, Bari, f1_man, f2_man, g_man, BLoc, CLoc, d, mx_el);

DirVal_vec = [DirVal.u1; DirVal.u2; DirVal.p];
% Imposition of BC
[H_bc, rhs_bc] = ImposeBC(n_nod, n_el, H, rhs, DirNod, DirVal_vec, coord, Areas_node, mx_el, inp);

% Solution of the system
[sol_num] = solver(H_bc, rhs_bc);
if mx_el == 2
    u1_num = sol_num(1:n_nod+n_el);
    u2_num = sol_num(n_nod+n_el+1:2*(n_nod+n_el));
    p_num = sol_num(2*(n_nod+n_el)+1:end-1);
else
    u1_num = sol_num(1:n_nod);
    u2_num = sol_num(n_nod+1:2*n_nod);
    p_num = sol_num(2*n_nod+1:end-1);
end

if inp == 0
    [u_xx, u_yy] = sec_dev(coord, n_nod);
    sec_norm = norm(u_xx+u_yy);
end

[res_u1, res_u2, res_p, res_tot] = Sol_Plot(triang, coord, Bari, u1_man, u2_man, p_man, u1_num, u2_num, p_num, inp, n_nod, n_el, mx_el);

if inp == 0
    fprintf('Residual (u1_man-u1_num): %f\n',res_u1);
    fprintf('Norm of the trace of the Hessian: %f\n',sec_norm);
    fprintf('Residual (u2_man-u2_num): %f\n',res_u2);
    fprintf('Residual (p_man-p_num): %f\n',res_p);
    fprintf('------------------------------------\n')
    fprintf('Total Residual: %f\n',res_tot);
end