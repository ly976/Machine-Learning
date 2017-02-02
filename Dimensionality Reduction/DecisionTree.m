% This function implements the main learning algrithm of decision tree.


function tree = DecisionTree(feature,label)

% if the left node is pure, return the label
if (length(unique(label)) == 1)
    tree.op = [];
    tree.threshold = [];
    tree.kids=[];
    tree.class = unique(label);
    return;
end

if (size(feature,2) == 0)
    tree.op = [];
    tree.threshold = [];
    tree.kids=[];
    tree.class = mode(label);
    return;
end

% get the best feature for root node.
[best_feature,best_threshold] =ChooseAttribute(feature,label);

tree.op = best_feature;
tree.threshold = best_threshold;
left = find(feature(:,best_feature)<= feature(best_threshold,best_feature));
right = find(feature(:,best_feature)> feature(best_threshold,best_feature));


if isempty(left)
    lefttree.op =[];
    lefttree.threshold = best_threshold;
    lefttree.kids = [];
    lefttree.class = mode(label);
    feature(:,best_feature)=[];
    righttree = DecisionTree(feature(right,:),label(right));
    tree.kids = {lefttree,righttree};
    tree.class = [];
    return;
end
if isempty(right)
    righttree.op =[];
    righttree.threshold = best_threshold;
    righttree.kids = [];
    righttree.class = mode(label);
    feature(:,best_feature)=[];
    lefttree = DecisionTree(feature(left,:),label(left));
    tree.kids = {lefttree,righttree};
    tree.class = [];
    return;
end


lefttree = DecisionTree(feature(left,:),label(left));
righttree = DecisionTree(feature(right,:),label(right));
tree.kids = {lefttree,righttree};
tree.class = [];



