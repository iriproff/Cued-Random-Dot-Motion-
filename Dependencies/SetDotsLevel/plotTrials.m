function plotTrials (data)

cohSample = unique(data(:,1));
colormap(hsv(length(cohSample)));
c = colormap(jet);
cla
figure
% coherence, per trial
subplot(3,1,1);
ylabel('Coherence');
title('Coherence per trial');
%text(.5,.93,'Coherence per trial')

for x = 1 : length(data(:,1))
    
    
    color   = c(cohSample == data(x,1),:);%[(data(x,2)~=1) 0 0];
    fcolor  = [1 1 1]*~data(x,2) + (data(x,2)*color);
    markers = {'o' ,'o' };
    marker = markers(data(x,2) + 1);
    hold on
    plot(x,data(x,1),char(marker),'Color', color,'markerfacecolor', fcolor,'markersize',4);

end



% p-value, per trial
subplot(3,1,2);
ylabel('p-Value');
title('p-Value per trial');
%text(.5,.93,'p-value per trial')

for x = 1 : length(data(:,1))

    color   = c(cohSample == data(x,1),:);%[(data(x,2)~=1) 0 0];
    markers = {'o' ,'o' };
    
    fcolor  = [1 1 1]*~data(x,2) + (data(x,2)*color);
    marker  = markers(data(x,2) + 1);
    hold on
    
    select  = data(1:x,1) == data(x,1);
    p       = data(1:x,2);
    p       = mean(p(select));    
    plot(x,p,char(marker),'Color', color,'markerfacecolor', fcolor,'markersize',4);
    

end

set(gca,'ylim',[0.4 1.1])
% p-value, per trial
subplot(3,1,3);
ylabel('RT(s)');
title('RT per trial');
%text(.5,.93,'p-value per trial')

for x = 1 : length(data(:,1))
    
    color   = c(cohSample == data(x,1),:);%[(data(x,2)~=1) 0 0];
    fcolor  = [1 1 1]*~data(x,2) + (data(x,2)*color);
    markers = {'o' ,'o' };
    marker  = markers(data(x,2) + 1);
    hold on
    
    
    rt      = data(x,3);   
    plot(x,rt,char(marker),'Color', color,'markerfacecolor', fcolor, 'markersize',4);
    
end


