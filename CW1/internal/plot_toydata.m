function  plot_toydata(data, fmt)
title('Axis Aligned')
if strcmp(fmt,'train')
    plot(data(data(:,end)==1,1), data(data(:,end)==1,2), 'o', 'MarkerFaceColor', [.9 .5 .5], 'MarkerEdgeColor','k');
    hold on;
    plot(data(data(:,end)==2,1), data(data(:,end)==2,2), 'o', 'MarkerFaceColor', [.5 .9 .5], 'MarkerEdgeColor','k');
    hold on;
    plot(data(data(:,end)==3,1), data(data(:,end)==3,2), 'o', 'MarkerFaceColor', [.5 .5 .9], 'MarkerEdgeColor','k');
    axis([-1.5 1.5 -1.5 1.5]);    
elseif strcmp(fmt,'test')
    plot(data(data(:,end)==1,1), data(data(:,end)==1,2), 'r.')%, 'MarkerFaceColor', [.9 .5 .5]);
    hold on;
    plot(data(data(:,end)==2,1), data(data(:,end)==2,2), 'g.')%, 'MarkerFaceColor', [.5 .9 .5]);
    hold on;
    plot(data(data(:,end)==3,1), data(data(:,end)==3,2), 'b.')%, 'MarkerFaceColor', [.5 .5 .9]);
    axis([-1.5 1.5 -1.5 1.5]);  
elseif strcmp(fmt,'testsmall')
    plot(data(data(:,end)==1,1), data(data(:,end)==1,2), 'rd', 'MarkerFaceColor', [.9 .5 .5], 'MarkerSize', 10);
    hold on;
    plot(data(data(:,end)==2,1), data(data(:,end)==2,2), 'gd', 'MarkerFaceColor', [.5 .9 .5], 'MarkerSize', 10);
    hold on;
    plot(data(data(:,end)==3,1), data(data(:,end)==3,2), 'bd', 'MarkerFaceColor', [.5 .5 .9], 'MarkerSize', 10);
    axis([-1.5 1.5 -1.5 1.5]);      
end

