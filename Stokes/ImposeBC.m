function [H_bc, rhs_bc] = ImposeBC(n_nod, n_el, H, rhs, DirNod, DirVal_vec, coord, Areas_node, mx_el, inp)

H_bc = H;
rhs_bc = rhs;
d_ = size(H,1);

if inp == 0
    for v=1:3
        for nd=1:length(DirNod)
            if mx_el == 2
                k = DirNod(nd) + (n_nod+n_el)*(v-1);
            else
                k = DirNod(nd) + n_nod*(v-1);
            end
            % Uplift BO for the rhs
            rhs_bc = rhs_bc - H_bc(:,k)*DirVal_vec(k);
            % Uplift BO for the Stiffness matrix
            H_bc(k,:)=zeros(1,d_);
            H_bc(:,k)=zeros(d_,1);
            H_bc(k,k)=1;
        end
    end
else
    for v=1:2
        for nd=1:n_nod
            if coord(nd,1) == 0 || coord(nd,1) == 1 || coord(nd,2) == 0 || coord(nd,2) == 1
                if mx_el == 2
                    k = nd + (n_nod+n_el)*(v-1);
                else
                    k = nd + n_nod*(v-1);
                end
            end
            % Uplift BO for the rhs
            rhs_bc = rhs_bc - H_bc(:,k)*DirVal_vec(k);
            % Uplift BO for the Stiffness matrix
            H_bc(k,:)=zeros(1,d_);
            H_bc(:,k)=zeros(d_,1);
            H_bc(k,k)=1;
        end
    end
end

if inp == 0
    for v=1:3
        for nd=1:length(DirNod)
            if mx_el == 2
                k = DirNod(nd) + (n_nod+n_el)*(v-1);
            else
                k = DirNod(nd) + n_nod*(v-1);
            end
            rhs_bc(k) = DirVal_vec(k);
        end
    end
else
    for v=1:2
         for nd=1:n_nod
            if coord(nd,1) == 0 || coord(nd,1) == 1 || coord(nd,2) == 0 || coord(nd,2) == 1
                if mx_el == 2
                    k = nd + (n_nod+n_el)*(v-1);
                else
                    k = nd + n_nod*(v-1);
                end
            end
            rhs_bc(k) = DirVal_vec(k);
         end
    end
end

%Pressure mean equal to 0
rhs_bc = [rhs_bc; 0];
if mx_el == 2
    h = [zeros(2*(n_nod+n_el),1); Areas_node];
else
    h = [zeros(2*n_nod,1); Areas_node];
 end
 H_bc = [ H_bc, h;
          h', 0    ];

end