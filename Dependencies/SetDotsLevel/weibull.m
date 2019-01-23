function [Q_fit, Psych_fit,coherence_axis, Dev,e] = weibull(fitData, plot_switch)

% get the fit -> [fits_,sems_,stats_,preds_,resids_,e]
[Q_fit,sems_,stats_] = quick_fit(fitData(:,1:2));

% set error flag as 'ok'
e=1;

% if bad fit...try with collapsed data
if Q_fit(1)<0.01
   
   % make summary
   data_sum = makeSummary(fitData);
   
   % get the fit
   [Q_fit,sems_,stats_]        = quick_fit(data_sum, 0.5);

   % if it still sucks..
   if Q_fit(1)<0.01
      % set error flag as 'suck'..
      e=0; 
   end
end
  


% deviance from the data (saturated model)
Dev                 = stats_(2);


% ... curve
coherence_axis  =   linspace(1,100,5000);
gamma           =   0.5;
i               =   coherence_axis;
Psych_fit       =   gamma + (1 - gamma - Q_fit(3)).* (1 - exp( -(i./Q_fit(1)).^Q_fit(2) ));

   
if plot_switch == 1
    
    figure
    axP = subplot(2,1,1, 'XScale', 'log');
    set(axP, 'ylim',[.5 1])
    % plot the data points
    data_sum = makeSummary(fitData);
    plot(data_sum(:,1), data_sum(:,2),  'o','Markeredgecolor',[0 0 1],'Markerfacecolor',[0 0 1],'Parent', axP);
    % stukje text
    text(min([data_sum(:,1)]) , .9, ['Weibull'], 'Color', [0 0 0], 'Parent', axP,'FontSize',8);
    
    hold on
    plot(coherence_axis,Psych_fit,'-', 'color',[1 0 0])
    
    set(gca, 'xscale','log')
    
end

