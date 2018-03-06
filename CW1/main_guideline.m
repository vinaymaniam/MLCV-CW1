clear
rng default
% Simple Random Forest Toolbox for Matlab
% written by Mang Shao and Tae-Kyun Kim, June 20, 2014.
% updated by Tae-Kyun Kim, Feb 09, 2017

% This is a guideline script of simple-RF toolbox.
% The codes are made for educational purposes only.
% Some parts are inspired by Karpathy's RF Toolbox

% Under BSD Licence

% % Initialisation
% init;

% % Select dataset
% [data_train, data_test] = getData('Toy_Spiral'); % {'Toy_Gaussian', 'Toy_Spiral', 'Toy_Circle', 'Caltech'}
% 
% % Set the random forest parameters
% N = 5;
% 
% nums = round(logspace(0, 2, N));
% depths = round(logspace(0.301, 1.114, N));
% splitnums = round(logspace(0, 1.3, N));
% 
% % for i = 1:N
%     figure;  
%     tic
%     plot_toydata(data_train);
% 
%     scatter(data_test(:,1),data_test(:,2),'.b');
%     
%     
%     param.num = 10;         % Number of trees
%     param.depth = 5;        % trees depth
%     param.splitNum = 3;     % Number of split functions to try
%     param.split = 'IG';     % Currently support 'information gain' only
% 
% %     param.num = nums(i);            % Number of trees
% %     param.depth = depths(i);        % trees depth
% %     param.splitNum = splitnums(i);  % Number of split functions to try
% %     param.split = 'IG';     % Currently support 'information gain' only
%     %%%%%%%%%%%%%%%%%%%%%%
%     % Train Random Forest
% 
%     % Grow all trees
%     trees = growTrees(data_train,param);
%     % trees = growTrees(data_train,param);
% 
% 
%     %%%%%%%%%%%%%%%%%%%%%%
%     % Evaluate/Test Random Forest
% 
%     % grab the few data points and evaluate them one by one by the leant RF
%     test_point = [-.5 -.7;...
%                    .4 .3;...
%                    -.7 .4;...
%                    .5 -.5];
% leaves=testTrees_fast(data_test,trees,param.weakLearner) + 1;
% 
% %append new row to prob
% p_rf = trees(1).prob(leaves,:);
% 
% % get the probabilities of the each class
% p_rf_sum=[sum(reshape(p_rf(:,1),[length(data_test),param.num]),2)...
%           sum(reshape(p_rf(:,2),[length(data_test),param.num]),2)...
%           sum(reshape(p_rf(:,3),[length(data_test),param.num]),2)]./param.num;
% end
% 
% % Test on the dense 2D grid data, and visualise the results ... 
% 
% 
% 
% % Change the RF parameter values and evaluate ... 





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% experiment with Caltech101 dataset for image categorisation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% init;

% Select dataset
% we do bag-of-words technique to convert images to vectors (histogram of codewords)
% Set 'showImg' in getData.m to 0 to stop displaying training and testing images and their feature vectors
[data_train, data_test] = getData('Caltech');
close all;



% Set the random forest parameters ...
param.num = 100;         % Number of trees
param.depth = 5;        % trees depth
param.splitNum = 3;     % Number of split functions to try
param.split = 'IG';     % Currently support 'information gain' only

% Train Random Forest ...
trees = growTrees(data_train,param);

% Evaluate/Test Random Forest ...
leaves = testTrees_fast(data_test,trees);

% Create p_rf
p_rf = trees(1).prob(leaves,:);

p_rf_sum=zeros(size(data_test,1),10);
for i=1:10
    p_rf_sum(:,i)=sum(reshape(p_rf(:,i),[size(data_test,1),param.num]),2);
end
p_rf = p_rf_sum;
% show accuracy and confusion matrix ...
confus_script;

wrongClass = data_test(data_test(:,end)~=c');
rightClass = data_test(data_test(:,end)==c');

disp('Done');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% random forest codebook for Caltech101 image categorisation
% .....



