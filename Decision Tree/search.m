
function label = search (Input, tree)
load('emotions_data.mat');
pos = tree.threshold;


if (~isempty(tree.class))
    label = tree.class;
    return;
else
    i = tree.op;
    if (Input (:, i) <= x (pos,i))
        label = search (Input,tree.kids{1});
        return;
    else
        label = search (Input,tree.kids{2});
        return;
    end
    
end