function [idx_, dim, t] = axisAligned(D, data)
    % Pick random dimension
    dim = randsample(D-1,1); 
    % Find range of dimension
    datamin = min(data(:,dim)); 
    datamax = max(data(:,dim));
    % Pick random threshold within range
    t = datamin + rand*((datamax-datamin)); 
    idx_ = data(:,dim) < t;
end