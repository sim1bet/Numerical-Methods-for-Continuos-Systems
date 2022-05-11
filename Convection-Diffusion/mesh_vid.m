function mesh_vid(u_num, i, triang, coord, D)

%txt = 'Diffusion: '+string(D(i));

figure(i);
trisurf(triang, coord(:,1), coord(:,2), u_num);
title('Convection Diffusion Surface');
xlabel('x');
ylabel('y');
%legend(txt)

end