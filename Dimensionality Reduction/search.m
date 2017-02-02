
function label = search (Input, tree, set)

pos = tree.threshold;

if (~isempty(tree.class))
    label = tree.class;
    return;
else
  
    i = tree.op;
    if (Input (:, i) <= set(pos,i))
        label = search (Input,tree.kids{1},set);
        return;
    else
        label = search (Input,tree.kids{2},set);
        return;
    end
    
end