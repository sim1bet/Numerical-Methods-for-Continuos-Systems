function [H_d, rhs] = DirH(H, DirNod, DirVal, BC)

% function that imposes BC either with the penalty approach 
% or with a boundary uplifting operator

H_d = H;
penalty = 10^(40);

rhs = zeros(size(H,1),1);

for j=1:length(DirNod)
    k = DirNod(j);
    if BC == 0
        
        H_d(k,k) = penalty;
        rhs(k) = penalty*DirVal(j);
        
    elseif BC == 1
        
        rhs = rhs - H_d(:,k)*DirVal(j);
        H_d(k,:) = 0;
        H_d(:,k) = 0;
        H_d(k,k) = 1;
        
    end
end

if BC == 1
    for j=1:length(DirNod)
        k = DirNod(j);
        rhs(k) = DirVal(j);
    end
end

end