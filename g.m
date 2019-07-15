function out = g( M,x,y )
%G Get the coordination with periodic bound conditions
%   With periodic bound conditions
limit = size(M);
if x>limit(1)
    x = x - limit(1);
elseif x<=0
    x = x + limit(1);
end

if y>limit(2)
    y = y - limit(2);
elseif y<=0
    y = y + limit(2);
end
out = M(x,y);
end