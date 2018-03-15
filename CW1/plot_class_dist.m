function plot_class_dist(trees, nleaves)
    switch nleaves
        case 2
            m = 1; n = 2;
        case 4
            m = 1; n = 4;
        case 6
            m = 2; n = 3;
        case 8
            m = 2; n = 4;
    end
    figure;    
    for i=1:nleaves
        subplot(m,n,i);
        bar(trees(1).prob(i+1,:));        
        grid minor;
        title(sprintf('Leaf: %d', i));
        axis([0.5 3.5 0 1]);
    end
    suptitle(sprintf('Class Distribution of first %i leaf nodes',nleaves));
end