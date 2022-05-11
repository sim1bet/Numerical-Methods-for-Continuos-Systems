function Area = det_el(element, coord)

% Computation of the determinant of the Van Dermonde matrix for the
% definition of the coefficients (for the local basis)

    VanDer = ones(3,3);
    for j=1:3
        VanDer(j,2) = coord(element(j),1);
        VanDer(j,3) = coord(element(j),2);
    end
    Area = det(VanDer)/2;
end