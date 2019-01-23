function [coherence_axis, Psych_fit, Chrono_fit] = plotPalmer(Q_fit, fitData, colorD, colorF)


% Q (or Q_fit) is a 6-element vector of fitted drift-diffusion parameters:
%
%   Q(1:3) are generic, ideal drift-diffusion parameters:
%       Q(1) is k, the scale factor for stimulus stimulus strength.
%       Q(2) is b (or beta), the exponent of facilitation for stimulus
%       strength.
%       Q(3) is A', the normalized bound height for accumulation (assumes
%       symmetric bounds A'=B');
%
%   Q(4:6) are for accomodating real data:
%       Q(4) is the psychometric lapse rate or upper asymptote.
%       Q(5) is the psychometric guess rate or lower asymptote.
%       Q(6) is tR, the residual, non-decision response time.


if nargin<3
    colorD = [0 0 1];
    colorF = [1 0 0];
end

% get stuff to send back...
coherence_axis  = linspace(1,100,5000);
Psych_fit       = ddRT_psycho_val(Q_fit, coherence_axis);
Chrono_fit      = ddRT_chrono_val(Q_fit, coherence_axis);



    
    %figure
    cohSample = unique(fitData(:,1));
    
    % plot data
    for ii = 1:length(cohSample)
        
        % choices are 1 for correct and 0 for incorrect
        Pc(ii) = mean( fitData(fitData(:,1)         == cohSample(ii),2));
        select = (fitData(:,2) == 1 & fitData(:,1)  == cohSample(ii));
        RT(ii) = mean(fitData(select,3)); % ONLY CORRECT
    end
    
    
    % Let's look at the functions over log coherence
    axP = subplot(2,1,1, 'XScale', 'log');
    axC = subplot(2,1,2, 'XScale', 'log');
    
    
    % plot the summary data over the "true" functions
     hold on
    plot(cohSample, Pc,  'o','Markeredgecolor',colorD,'Markerfacecolor',colorD, 'Parent',axP);
    % stukje text
    text(min([cohSample]) , .9, ['Palmer'], 'Color', [0 0 0], 'Parent', axP,'FontSize',8);

    set(axP, 'xscale','log') % somehow log above is not set properly...
    set(axP, 'ylim',[.4 1])
    
    hold on
    plot(cohSample, RT,  'o','Markeredgecolor',colorD,'Markerfacecolor',colorD, 'Parent',axC);
    set(axC, 'xscale','log')
    % plot fit
    line(coherence_axis, Psych_fit, 'Color', colorF, 'Parent', axP);
    line(coherence_axis, Chrono_fit, 'Color', colorF, 'Parent', axC);
   
    
    
