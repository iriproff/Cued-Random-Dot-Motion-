function [coh_sim_palm, coh_sim_weib, D_palm, D_weib]  = BootFits (fitData, weib, palm, aantal, level)

coh_sim_palm = [];
coh_sim_weib = [];

D_weib = [];
D_palm = [];

cohSample = unique(fitData(:,1));

disp('Running bootstrap...')

for ii =1:aantal
    fitData_sim=[];
    %disp(ii)
    for i = 1:length(cohSample)
        
        coh_data    = fitData(fitData(:,1) == cohSample(i),:);
        rndList     = randsample([1:length(coh_data(:,1))],size(coh_data,1),true)';
        coh_data    = coh_data(rndList,:);
        
        
        % new data    
        fitData_sim  = [fitData_sim; coh_data];
        
    end
    
    if palm == 1
        
        % no plot
        plot_switch = 0;
        % do the fit
        [Q_fit, Psych_fit,Chrono_fit,coherence_axis, Dev, exitFlag] =  palmer(fitData_sim, plot_switch);
        
        % if the fit was ok...
        if exitFlag~=0 
            % coherence that we want...
            coh_sim_palm(end+1,1) = coherence_axis(find( Psych_fit <= level, 1, 'last' ));
            %Deviance
            D_palm(end + 1,1) = Dev;
        end
        
    end
    
    if weib == 1
        % no plot
        plot_switch = 0;
        % dot the fit...
        [Q_fit, Psych_fit,coherence_axis, Dev, exitFlag] = weibull(fitData_sim, plot_switch);
        
        % if the fit did work...
        if exitFlag~=0
            % coherence that we want...
            coh_sim_weib(end+1,1)   = coherence_axis(max(find( Psych_fit <= level)) );
            %Deviance
            D_weib(end + 1,1) = Dev;
        
        end
        
    end
    
    
end