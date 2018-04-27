function [centroids, time] = kmeanscodebook(data, nbins, nrepeat)    
%     energy = inf;
    energies = zeros(1, nrepeat);
    ctrds = zeros(nbins, 128, nrepeat);
    tic;
    parfor i=1:nrepeat
        [~, ctrds(:,:,i), E] = kmeans(data, nbins, 'MaxIter', 1000);
        energies(i) = sum(E);
    end    
    bestidx = find(energies == min(energies));
    centroids = ctrds(:,:,bestidx);    
%     for i=1:nrepeat
%         [kmeansIdx1, centroids1, energy1] = kmeans(data, nbins, 'MaxIter', 100);
%         if energy1 < energy
%             kmeansIdx = kmeansIdx1;
%             centroids = centroids1;
%             energy = energy1;
%         end
%     end
%     [kmeansIdx, centroids, ~] = kmeans(data, nbins, 'MaxIter', 100, 'Replicates', nrepeat);    
    time = toc;
end