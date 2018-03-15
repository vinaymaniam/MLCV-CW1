function codebook_RF = find_codebook_RF( trees ) % Collates all codewords from tree 
num_trees = size(trees,2); 
num_class = size(trees(1).prob,2); 
codebook_RF = []; 
for index1 = 1:num_trees 
    num_nodes = size(trees(index1).node,2); 
    for index2 = 1:num_nodes 
        if(isoneclass(trees(index1).node(index2).prob,num_class)) 
            codebook_RF = [codebook_RF trees(index1).node(index2).idx]; 
        end
    end
end
codebook_RF = unique(codebook_RF);