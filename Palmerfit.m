

%%%%%%%%%% Palmer fit %%%%%%%%%%%%%%%%%%

% Read in excel sheet
addpath(genpath('Dependencies'));
subject = input('Enter the subject number ','s');
accuracy = input('Enter the desired accuracy in %');

%filename = strcat('C:\Users\irisp\Documents\CogSci UVA\Internship\Data\Subjects\', subject,'\', subject,'-palmer.csv');
filename = strcat('D:\Data EEG\Data\Subjects\', subject,'\', subject,'-palmer.csv');
%filename = strcat('C:\Users\irisp\Dosub8cuments\CogSci UVA\Internship\Experiment\logfiles\pilots\', subject, '-palmer.csv');
[sub_data,txt] = xlsread(filename);
subject_data = array2table(sub_data,'VariableNames', txt(1,:));

% Get the coherenc5e (8), accuracy(4), response time(6) columns

fit_data = horzcat(sub_data(:,8), sub_data(:,4), sub_data(:,6));
fit_data(:,3) = fit_data(:,3)/1000;
fit_data(fit_data(:,2)==-1,2)= 0;


% throw away misses and RT < 100 ms
fit_data = fit_data(fit_data(:,3) > 0.1,:);

plot_switch = 1;

% fit the Palmer function

[Q_fit, Psych_fit,Chrono_fit,coherence_axis, Dev_palm] = palmer(fit_data, plot_switch);

% get pmf when lapse ~ 0;
Q_fit(4)        = 0.001;
Psych_fit_opt   = ddRT_psycho_val(Q_fit, coherence_axis);

% coherence that we want... here it's set at 80% correct.
coh_palmer = coherence_axis(find( Psych_fit_opt <= accuracy/100, 1, 'last' ) );


% build in double check... if the coherence is really nonsense:
% assume that they will get better... Note: this is really arbitrary 
% so that we don't loose any data...

if isempty(coh_palmer)      
    coh_palmer = 0;       
end

disp(strcat('Coherence:', num2str(coh_palmer)));
%%
mean_accuracy = mean(fit_data(:,2));
mean_RT = mean(fit_data(:,3));

coh = [1,5,10,15,20,40,80];
mean_acc_per_coh = zeros(length(coh),1);
mean_RT_per_coh = zeros(length(coh),1);
misses = length(find(subject_data.correct ==-1));
counter = 1;
for i = [1,5,10,15,20,40,80] 
   mean_acc_per_coh(counter) = mean(fit_data(fit_data(:,1) ==i,2));
   mean_RT_per_coh(counter) = mean(fit_data(fit_data(:,1) ==i,3));
   counter=counter+1;
end


