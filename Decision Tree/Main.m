% This function generated six decision trees on the whole dataset.

load('emotions_data.mat');


for k = 1:6
    label = (y==k);
    filename =['tree',num2str(k)];
    tree = DecisionTree( x ,label);
    DrawDecisionTree(tree,['decision_',filename]);
    eval(['decision_' filename '=tree']);
    save ( filename,['decision_',filename]);
end
