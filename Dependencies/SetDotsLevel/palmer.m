function [Q_fit, Psych_fit,Chrono_fit,coherence_axis, Dev, exitFlag] =  palmer(fitData, plot_switch)

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


% ddRT_initial_params calculates reasonable starting values, given the
%   dataset.
Q_guess = ddRT_initial_params(fitData);

% ddRT_bound_params gives some reasonable upper and lower bounds for each
%   of the parameters.
%   You might wish to change these.
%   For now, they only allow k, A', and tR to vary.  b, l, and g are fixed.
Q_bounds = ddRT_bound_params;
Q_bounds(4,:) = [.0001, .2];    % lapse (same bounds as in quick_fit
%Q_bounds(4,:) = [.01, .01];  
Q_bounds(5,:) = [.5, .5];       % guess
Q_bounds(6,:) = [.2, 1];        % Ter

% default optimset fminSearch
%     Display: 'notify'
%     MaxFunEvals: '200*numberofvariables'
%         MaxIter: '200*numberofvariables'
%          TolFun: 1.0000e-004
%            TolX: 1.0000e-004
%     FunValCheck: 'off'
%       OutputFcn: []
%        PlotFcns: []


% The fitting function, fmincon, needs a few settings
opt = optimset( ...
    'Display',      'off', ...
    'MaxIter',      1e5, ...
    'MaxFunEvals',  1e5);




% Do maximum likelihood fit the 6 parameters, using choice and RT data
% simultaneously.
%   @ddRT_psycho_nll gives the negative log likelihood of the choices in
%   fitData, given a set of parameters, Q.
%   @ddRT_chrono_nll_from_pred gives the negative log likelihood of the
%   mean reaction times at each coherence.  It predicts the variance of
%   reaction times, from the drift-diffusion model, rather than using the
%   variance of the observed RTs.
% [Q_fit, Qerr, errVal, exitFlag, outputInfo] = ddRT_fit( ...
%     @ddRT_psycho_nll, ...
%     @ddRT_chrono_nll_from_data, ...
%     fitData, [Q_guess, Q_bounds], opt);

% [x,fval,exitflag,output]
[Q_fit, errVal, exitFlag, outputInfo] = ddRT_fit_fSearchbnd( ...
    @ddRT_psycho_nll, ...
    @ddRT_chrono_nll_from_data_k37, ...
    fitData, [Q_guess, Q_bounds], opt);


% outputInfo.message

% send stuff back ...
coherence_axis  = linspace(1,100,5000);
Psych_fit       = ddRT_psycho_val(Q_fit, coherence_axis);
Chrono_fit      = ddRT_chrono_val(Q_fit, coherence_axis);

% deviance from the data (saturated model)
Dev = -2*(-errVal);



if plot_switch == 1
    
    plotPalmer(Q_fit,fitData);
    
end
    