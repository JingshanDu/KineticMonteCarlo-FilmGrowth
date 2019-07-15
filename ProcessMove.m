function ProcessMove( x,y,Estep )
%PROCESSMOVE Summary of this function goes here
%   Detailed explanation goes here
global Position Potential T k;

for Pstep=1:Estep
%     if Position(x,y)==1
%         p=Inf;
%     else
%         p = Potential(x,y);
%     end
    p_n = [g(Potential,x-1,y) g(Potential,x+1,y) g(Potential,x,y-1) g(Potential,x,y+1) Potential(x,y)];
    ps_n = ~[g(Position,x-1,y) g(Position,x+1,y) g(Position,x,y-1) g(Position,x,y+1) Position(x,y)];
    p_na = diag(p_n'*ps_n)';%accessible
    p_na(p_na==0)=Inf;
    % find the smallest elementS
    pmin = min(p_na);
    imin = find(p_na == pmin);   %This might be a vector!

    if pmin<p_na(5)   % Boltzmann's Factor > 1, so certainly happens
        [x y] = MoveTo(x,y,imin);
    else
        % Diffusion by Boltzmann's Factor
        bf = exp(-(p_na-p_na(5))/k/T);
        % if all neighbors & the point itself are all occupied
        if isnan(bf(5))
            bf(isnan(bf))=1;
            Pstep = Pstep + 1; %#ok<FXSET>
        end
        
        bf_a = bf*triu(ones(5,5),0);
        bf_a = bf_a / bf_a(5);
        r = rand(1);

        for i=1:4
            if r<bf_a(i)
                [x y] = MoveTo(x,y,i);
                break
            end
        end
        % if not found, do not move
    end
end
% update position
Position(x,y) = 1;
end
