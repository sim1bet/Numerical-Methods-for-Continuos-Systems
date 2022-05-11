function [res_u1, res_u2, res_p, res_tot] = Sol_Plot(triang, coord, Bari, u1_man, u2_man, p_man, u1_num, u2_num, p_num, inp, n_nod, n_el, mx_el)

if mx_el == 2
    x = [coord(:,1); Bari(:,1)];
    y = [coord(:,2); Bari(:,2)];
    
    x_aux = coord(:,1);
    y_aux = coord(:,2);
else
    x = coord(:,1);
    y = coord(:,2);
    
    x_aux = x;
    y_aux = y;
end

figure(1);
%sgtitle('Numerical Solutions');
trisurf(triang, x, y, u1_num);
xlabel('x - coord');
ylabel('y - coord');
title('u1 num.');
    

figure(2);
trisurf(triang, x, y, u2_num);
xlabel('x - coord');
ylabel('y - coord');
title('u2 num.');
    
figure(3);
trisurf(triang, x_aux, y_aux, p_num);
xlabel('x - coord');
ylabel('y - coord');
title('p num.');
    


if inp == 0
    if mx_el == 2
        u1_an = vec_gen(u1_man, [coord; Bari], n_nod+n_el);
        u2_an = vec_gen(u2_man, [coord; Bari], n_nod+n_el);
        p_an = vec_gen(p_man, coord, n_nod);
    else
        u1_an = vec_gen(u1_man, coord, n_nod);
        u2_an = vec_gen(u2_man, coord, n_nod);
        p_an = vec_gen(p_man, coord, n_nod);
    end
    
    figure(4)
    trisurf(triang, x, y, u1_an);
    xlabel('x - coord');
    ylabel('y - coord');
    title('u1 an.');
    
    figure(5)
    trisurf(triang, x, y, u2_an);
    xlabel('x - coord');
    ylabel('y - coord');
    title('u2 an.');
    
    figure(6);
    trisurf(triang, x_aux, y_aux, p_an);
    xlabel('x - coord');
    ylabel('y - coord');
    title('p an.');
    
    format shortE
    m = squeeze(u1_num(1:n_nod) - u1_an(1:n_nod));
    n = squeeze(u2_num(1:n_nod) - u2_an(1:n_nod));
    o = squeeze(p_num - p_an);
    
    figure(7);
    trisurf(triang, x_aux, y_aux, m);
    xlabel('x - coord');
    ylabel('y - coord');
    title('u1_{num} - u1_{an}');
    
    figure(8);
    trisurf(triang, x_aux, y_aux, n);
    xlabel('x - coord');
    ylabel('y - coord');
    title('u2_{num} - u2_{an}');
    
    figure(9);
    trisurf(triang, x_aux, y_aux, o);
    xlabel('x - coord');
    ylabel('y - coord');
    title('p_{num} - p_{an}');
    
    res_u1 = norm(m,2);
    res_u2 = norm(n,2);
    res_p = norm(o,2);
    
    res_tot = norm([m; n; o]);
    
end

if inp == 1
    res_u1 = NaN;
    res_u2 = NaN;
    res_p = NaN;
    
    res_tot = NaN;
end



end