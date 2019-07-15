function [ x,y ] = MoveTo( x,y,Index )
%MOVETO Move an atom to the next position
%   Handles PBC & sampling of positions w/ same energy
global MeshNum
% Multi-positions
dim = size(Index);
if dim(2)>1
    % random
    ruler = linspace(0,1,dim(2)+1);
    r = rand(1);
    for i=2:dim(2)+1
        if r<ruler(i)
            Index = i-1;
            break
        end
    end
end

switch Index
    case 1
        x = x-1;
    case 2
        x = x+1;
    case 3
        y = y-1;
    case 4
        y = y+1;
end

if x>MeshNum
    x = x - MeshNum;
elseif x<=0
    x = x + MeshNum;
end

if y>MeshNum
    y = y - MeshNum;
elseif y<=0
    y = y + MeshNum;
end
    
end

