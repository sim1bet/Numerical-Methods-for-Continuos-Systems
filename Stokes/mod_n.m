function [r]=mod_n(i,j)

% Auxiliary mod function

if mod(i,j)==0
    r=j;
else
    r=mod(i,j);

end