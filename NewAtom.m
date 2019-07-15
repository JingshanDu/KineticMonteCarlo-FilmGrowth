function [x y] = NewAtom( maxnum )
%NEWATOM Summary of this function goes here
%   Detailed explanation goes here
out = deal(floor(maxnum*rand(1,2))+1);
x=out(1);
y=out(2);

end