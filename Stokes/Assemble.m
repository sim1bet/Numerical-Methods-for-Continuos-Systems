function [H] = Assemble(A, S, Div_NN_B, Div_NN_C, Div_NM_B, Div_NM_C, mx_el, n_nod)
% Construction of the final matrix H necessary to solve the Stokes equation
if mx_el == 2
    
    D_B = [Div_NN_B, Div_NM_B];
    D_C = [Div_NN_C, Div_NM_C];
    
    H = [ A, zeros(size(A)), D_B';
          zeros(size(A)), A, D_C';
          D_B, D_C, zeros(size(Div_NN_B))];
      
else
    D = [Div_NN_B, Div_NN_C];
    if mx_el == 0
        H = [ A, D';
              D, zeros(size(Div_NN_B))];
    elseif mx_el == 1
        H = [ A, D';
              D, -S];
    end
end

H = sparse(H);

end