function [label, mu, sumd] = kmeans_custom(X, k, max_iter)
    % Perform kmeans clustering.
    % Input:
    %   X: d x n data matrix
    %   k: initialization parameter
    % Output:
    %   label: 1 x n sample labels
    %   mu: d x k center of clusters
    %   energy: optimization target value
    % Written by Mo Chen (sth4nth@gmail.com).

    label = kmeans_init(X, k);
    n = numel(label);
    idx = 1:n;
    last = zeros(1,n);
    iter = 0;
    while (any(label ~= last)) && (iter < max_iter)
        [~,~,last(:)] = unique(label);                  % remove empty clusters
        mu = X*normalize(sparse(idx,last,1),1);         % compute cluster centers 
        [val,label] = min(dot(mu,mu,1)'/2-mu'*X,[],1);  % assign sample labels

        iter = iter + 1; % increment iter in case convergence never happens
    end
    sumd = sqrt(sum(dot(X,X,1)+2*val));
    mu = mu'; % Make mu kxd instead of dxk
    label = label'; % Make label nx1 instead of 1xn
end

function label = kmeans_init(X, k)
    [d,n] = size(X);
    if numel(k) == 1                           % random initialization
        mu = X(:,randperm(n,k));
        [~,label] = min(dot(mu,mu,1)'/2-mu'*X,[],1); 
    elseif all(size(k) == [1,n])               % init with labels
        label = k;
    elseif size(k,1) == d                      % init with seeds (centers)
        [~,label] = min(dot(k,k,1)'/2-k'*X,[],1); 
    end
end

