function [vec] = vec_gen(f, coord, n_nod)

vec = zeros(n_nod,1);
for n=1:n_nod
    vec(n) = f(coord(n,1),coord(n,2));
end

end