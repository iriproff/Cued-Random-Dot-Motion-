function trialList = shuffleRestrict(list)


% shuffle them rhe whole list ....
rndList         = Shuffle(1:length(list(:,1)));
trialList       = list(rndList,:);


% now check for consequentive trials with same condition
% (column 2)

% maximum allowed
rep = 2;

A_rnd       = trialList;



y=0;
x=1;

while ((x+rep)<=length(A_rnd(:,2)))==1
    
    un_A = unique(abs(A_rnd(x+1:x+rep,2)));
    
    if length(un_A)==1 && (abs(A_rnd(x,2)) == un_A)
        
        
        % show some stuff
        y=y+1;
        %A_rnd'
        
        %pause
        
        
        % put the current trial somewhere back in the list....
        
        r = Shuffle(1:length(A_rnd(:,2)));
        A_rnd_tmp           = A_rnd;
        A_rnd_tmp(x,:)        = A_rnd(r(x),:);
        A_rnd_tmp(r(x),:)     = A_rnd(x,:);
        A_rnd = A_rnd_tmp;
        
        x=0;
        
        % ... check if we're running out
        if y > 10*length(A_rnd(:,2)) 
           rndList         = Shuffle(1:length(list(:,1)));
           A_rnd           = list(rndList,:);
           x=0;
           y=0;
           r = r + 1;
           if r>2; quit; end
        end
        
    end
    x=x+1;
end


trialList = A_rnd;