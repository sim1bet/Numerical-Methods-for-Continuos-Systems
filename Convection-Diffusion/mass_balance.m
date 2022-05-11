function mb = mass_balance(u_num, H, DirNod, coord, v)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computation of the diffusive and convective fluxes at boundary nodes to
% verify that the net flux is approximately zero

mb_temp = - H*u_num;
diff_flux = zeros(length(u_num),1);
%conv_flux = zeros(length(u_num),1);
for j=1:length(DirNod)
    k = DirNod(j);
    diff_flux(k) = mb_temp(k);
end
% for j=1:size(coord,1)
%     if coord(j,1)== 0
%         if coord(j,2)~=0 && coord(j,2)~=1
%             n = [-1,coord(j,2)];
%             conv_flux(j) = u_num(j)*dot(n,v);
%         end
%     elseif coord(j,1) == 1
%         if coord(j,2)~=0 && coord(j,2)~=1
%             n = [1,coord(j,2)];
%             conv_flux(j) = u_num(j)*dot(n,v);
%         end
%     elseif coord(j,2) == 0
%         if coord(j,1)~=0 && coord(j,1)~=1
%             n = [coord(j,1),-1];
%             conv_flux(j) = u_num(j)*dot(n,v);
%         end
%     elseif coord(j,2) == 1
%         if coord(j,1)~=0 && coord(j,1)~=1
%             n = [coord(j,1),1];
%             conv_flux(j) = u_num(j)*dot(n,v);
%         end
%     end
% end

conv_flux = -v(1)-0.3*v(2);
mb = sum(diff_flux) + conv_flux;
%mb = sum(diff_flux + conv_flux);

end