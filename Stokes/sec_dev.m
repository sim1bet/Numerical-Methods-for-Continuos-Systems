function [u_xx,u_yy] = sec_dev(coord, n_nod)
    u_xx_f = @(x,y) 4*pi^2*cos(2*pi*x)*sin(2*pi*y)+sin(2*pi*y);
    u_yy_f = @(x,y) 4*pi^2*cos(2*pi*x)*sin(2*pi*y)-4*pi^2*sin(2*pi*y);
    
    u_xx = vec_gen(u_xx_f, coord, n_nod);
    u_yy = vec_gen(u_yy_f, coord, n_nod);
end