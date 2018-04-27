function [idx_, dim, t] = linearLearn( D, data )
% y = a*x + b

% Pick 2 random dimensions for x and y
dim = randsample(D-1,2);

t = zeros(1,2);
numer = 2*rand - 1;  denom = 2*rand - 1;
if denom == 0
    denom = sign(randn)*0.000001;
end
% This formula lets the gradient take any value(except +/- inf)
t(2) = numer/denom;
% Find range of values y intercept can take (b = y - a*x)
bRange = data(:,dim(2)) - t(2)*data(:,dim(1));
bMax = max(bRange);
bMin = min(bRange);

% Choose y intercept to be a random value within its possible range
t(1) = bMin + (bMax-bMin)*rand;

idx_ = (data(:,dim(2))-t(2)*data(:,dim(1))-t(1))<0;

end


