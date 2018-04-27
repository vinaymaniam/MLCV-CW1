[~,c] = max(p_rf');
accuracy_rf = sum(c==data_test(:,end)')/length(c); % Classification accuracy (for Caltech dataset)
idx = sub2ind([10, 10], data_test(:,end)', c);
% idx = sub2ind([10, 10], data_test(:,end)', c*ones(size(data_test(:,end)')));
conf = zeros(10);
conf = vl_binsum(conf, ones(size(idx)), idx);
figure('rend','painters','pos',[100 100 450 300])
imagesc(conf) ;
title(sprintf('Confusion matrix (%.2f %% accuracy)', 100 * accuracy_rf) ) ;