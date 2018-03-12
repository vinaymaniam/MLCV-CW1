function plot_class_dist(trees)
    figure;
    for i=1:16
        subplot(4,4,i);
        bar(trees(1).prob(i+1,:));        
        grid minor;
        title(sprintf('Leaf: %d', i),'FontSize', 20);
        axis([0.5 3.5 0 1]);
    end
end