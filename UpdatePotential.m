function UpdatePotential(lap, cutoff, Esup)
%UPDATEPotential Update the Position matrix
%   cutoff = n
global MeshNum Position Potential

tempP = [Position(MeshNum-cutoff+1:MeshNum,MeshNum-cutoff+1:MeshNum), Position(MeshNum-cutoff+1:MeshNum,:), Position(MeshNum-cutoff+1:MeshNum,1:cutoff);
         Position(:,MeshNum-cutoff+1:MeshNum), Position, Position(:,MeshNum-cutoff+1:MeshNum);
         Position(1:cutoff,MeshNum-cutoff+1:MeshNum), Position(1:cutoff,:), Position(1:cutoff,1:cutoff)];
     
for i=1:MeshNum
    for j=1:MeshNum
        Potential(i,j) = sum(sum(tempP(i:i+2*cutoff,j:j+2*cutoff).*lap),2)+Esup;
    end
end

end
