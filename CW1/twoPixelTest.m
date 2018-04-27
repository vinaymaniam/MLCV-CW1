function [idx_, dim, t] = twoPixelTest( D, data )
    dim = randsample(D-1,2);
    
    datamin = min(data(:,dim(1)) - data(:,dim(2)));
    datamax = max(data(:,dim(1)) - data(:,dim(2)));
    
    % Random threshold for splitting within the range     
    t = datamin + rand*(datamax-datamin);
    
    idx_ = data(:,dim(1)) - data(:,dim(2)) < t;
end