function data = mapWords(

data_train=zeros(nclasses*nimages,nLeaves+1);
% iterate over all points
k = 1;
for c=1:nclasses
    for i=1:length(imgIdx_tr)
        % for each descriptor, we create the histogram
        leaves=testTrees_fast(single(desc_tr{c,i}(1:end,:)'),trees,param.weakLearner);
        data_train(k,1:end-1)=histcounts(reshape(leaves,1,numel(leaves)),nLeaves)/length(leaves);
        data_train(k,end)=c;
        k = k+1;
    end
end