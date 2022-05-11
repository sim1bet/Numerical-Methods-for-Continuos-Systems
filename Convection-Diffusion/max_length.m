function l = max_length(triangle, coord)

length=zeros(3,1);

length(1) = sqrt((coord(triangle(1),1)-coord(triangle(2),1))^2 + ...
    (coord(triangle(1),2) - coord(triangle(2),2))^2);
length(2) = sqrt((coord(triangle(1),1)-coord(triangle(3),1))^2 + ...
    (coord(triangle(1),2) - coord(triangle(3),2))^2);
length(3) = sqrt((coord(triangle(3),1)-coord(triangle(2),1))^2 + ...
    (coord(triangle(3),2) - coord(triangle(2),2))^2);

l = max(length);

end