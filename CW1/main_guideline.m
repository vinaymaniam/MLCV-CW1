% clear
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

modes = {'Toy_Spiral', 'Caltech'};
mode = 1; %1 for toy spiral, 2 for caltech

switch mode
    case 1
        clear
        % Select dataset
        [data_train, data_test] = getData('Toy_Spiral'); % {'Toy_Gaussian', 'Toy_Spiral', 'Toy_Circle', 'Caltech'}

        % Set the random forest parameters
        N = 5;

        nums = round(logspace(0, 2, N));
        depths = round(logspace(0.301, 1.114, N));
        splitnums = round(logspace(0, log10(size(data_train,1)), N));

        tic

        param.num = 100;         % Number of trees [1 6 34 100 200]
        param.depth = 5;        % trees depth 2 5 10 15
        param.splitNum = 3;     % Number of split functions to try
        param.split = 'IG';     % Currently support 'information gain' only
        param.weakLearner = 'axisAligned'; % {'axisAligned','linear','nonLinear','twoPixelTest'}

        %%%%%%%%%%%%%%%%%%%%%%
        % Train Random Forest

        % Grow all trees
        trees = growTrees(data_train,param);
        % trees = growTrees(data_train,param);


        %%%%%%%%%%%%%%%%%%%%%%
        % Evaluate/Test Random Forest
        smallTest = 0;
        % grab the few data points and evaluate them one by one by the leant RF
        test_point = [-.5 -.7;...
                       .4 .3;...
                       -.7 .4;...
                       .5 -.5];
        if smallTest == 1
            data_test = test_point;
        end
        leaves=testTrees_fast(data_test,trees,param.weakLearner);

        %append new row to prob
        p_rf = trees(1).prob(leaves,:);

        % get the probabilities of the each class
        p_rf_sum=[sum(reshape(p_rf(:,1),[length(data_test),param.num]),2)...
                  sum(reshape(p_rf(:,2),[length(data_test),param.num]),2)...
                  sum(reshape(p_rf(:,3),[length(data_test),param.num]),2)]./param.num;

        [~,data_test(:,3)]=max(p_rf_sum');

        % Test on the dense 2D grid data, and visualise the results ... 
        figure('rend','painters','pos',[100 100 450 300])
        if smallTest == 1
            plot_toydata(data_test, 'testsmall');
            figure;
            for i = 1:4
                subplot(2,2,i);
                bar(p_rf_sum(i,:),1); 
                yl = xlim();
                axis tight;
                ylim([0 1])
                title(sprintf('Class Distribution for Point %i',i));
            end            
        else
            plot_toydata(data_test, 'test');
        end
        plot_toydata(data_train,'train');
%         title(sprintf('splitNum = %i',param.splitNum));

%         plot_class_dist(trees, 6);

        
        % Change the RF parameter values and evaluate ...         
    case 2
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        % experiment with Caltech101 dataset for image categorisation
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        % Set the random forest parameters ...
        param.num = 200;         % Number of trees
        param.depth = 5;        % trees depth
        param.splitNum = 15;     % Number of split functions to try
        param.split = 'IG';     % Currently support 'information gain' only
        param.weakLearner = 'axisAligned'; %{twoPixelTest, linearLearn, nonlinearLearn}
        param.numBins = 64;
        param.numRep = 2;

        tuneCodebook = 1;
        if tuneCodebook 
            clearvars -except param
            %[data_train, data_test] = getData('Caltech', 'kmeanscodebook', param);
            [data_train, data_test] = getData('Caltech', 'rfcodebook', param);
            %save(sprintf('codebook%i',param.numBins),'data_train','data_test');
            save(sprintf('rfcodebook%i',param.numBins),'data_train','data_test');
            close all;
        end        
        % Train Random Forest ...
        trees = growTrees(data_train,param);

        % Evaluate/Test Random Forest ...
        leaves = testTrees_fast(data_test,trees,param.weakLearner);

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
        
%         corrclassplt
%         misclassplt
%         figure;
%         for i = 1:3
%             subplot(2,3,i);
%             plot(
%         end
        disp('Done');
        %%
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        % random forest codebook for Caltech101 image categorisation
        % .....
    
end


        



