function [idx_, dim, t] = nonlinearLearn(D, data)
    % y = a*x^2 + b*x + c

    % Pick random dimensions for x and y
    dim = randsample(D-1,2);
    t = zeros(1,3);
    t(3) = (2*rand - 1);
    t(2) = (2*rand - 1);

    cRange = data(:,dim(2))-t(2).*(data(:,dim(1))).^2-t(3).*data(:,dim(1)); 
    cMin = min(cRange);
    cMax = max(cRange);

    t(1) = cMin + rand*(cMax - cMin);

    idx_ = data(:,dim(2)) - t(3)*(data(:,dim(1)).^2) - t(2)*data(:,dim(1)) - t(1) < 0;
end