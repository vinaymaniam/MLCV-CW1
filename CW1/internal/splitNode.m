function [node,nodeL,nodeR, ig_best] = splitNode(data,node,param)
% Split node

visualise = 0;


% Initilise child nodes
iter = param.splitNum;
nodeL = struct('idx',[],'t',nan,'dim',0,'prob',[]);
nodeR = struct('idx',[],'t',nan,'dim',0,'prob',[]);

if length(node.idx) <= 5 % make this node a leaf if has less than 5 data points
    node.t = nan;
    node.dim = 0;
    ig_best = 0;
    return;
end

idx = node.idx;
data = data(idx,:);
[N,D] = size(data);
ig_best = -inf; % Initialise best information gain
idx_best = [];
for n = 1:iter
%%    % Split function - Modify here and try other types of split function
    
    switch param.weakLearner
        case 'axisAligned'
            [idx_, dim, t] = axisAligned(D, data);
        case 'twoPixelTest'
            [idx_, dim, t] = twoPixelTest(D, data);
        case 'linear'
            [idx_, dim, t] = linearLearn(D, data);
        case 'nonLinear'
            [idx_, dim, t] = nonlinearLearn(D, data);
    end        
    ig = getIG(data,idx_); % Calculate information gain   
    if visualise
        visualise_splitfunc(idx_,data,dim,t,ig,n, param.weakLearner);
        pause();
    end    
    if (sum(idx_) > 0 & sum(~idx_) > 0) % We check that children node are not empty
        [node, ig_best, idx_best] = updateIG(node,ig_best,ig,t,idx_,dim,idx_best);
    end    
end

nodeL.idx = idx(idx_best);
nodeR.idx = idx(~idx_best);

if visualise
    visualise_splitfunc(idx_best,data,dim,t,ig_best,0, param.weakLearner)
    fprintf('Information gain = %f. \n',ig_best);
    pause();
end

end

function ig = getIG(data,idx) % Information Gain - the 'purity' of data labels in both child nodes after split. The higher the purer.
    L = data(idx,:);
    R = data(~idx,:);
    H = getE(data);
    HL = getE(L);
    HR = getE(R);
    ig = H - sum(idx)/length(idx)*HL - sum(~idx)/length(idx)*HR;
end

function H = getE(X) % Entropy
    cdist= histc(X(:,end), unique(X(:,end)));
    cdist= cdist/sum(cdist);
    cdist= cdist .* log(cdist);
    H = -sum(cdist);
end

function [node, ig_best, idx_best] = updateIG(node,ig_best,ig,t,idx,dim,idx_best) % Update information gain
if ig > ig_best
    ig_best = ig;
    node.t = t;
    node.dim = dim;
    idx_best = idx;
else
    idx_best = idx_best;
end
end