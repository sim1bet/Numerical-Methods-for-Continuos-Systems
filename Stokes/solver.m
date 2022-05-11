function [u_num]=solver(H_d, rhs)

u_num = H_d\rhs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GMRES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% restart = 10;
% tol = 1e-9;
% maxit = 20;
% 
% setup.type='nofill';
% setup.milu='off';
% 
% [L,U] = ilu(H_d, setup);
% u_num = gmres(H_d, rhs, restart, tol, maxit, L, U);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end