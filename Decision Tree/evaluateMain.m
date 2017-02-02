load('emotions_data.mat');

load('accuarcy');

Indices = crossvalind('Kfold',y', 10);

confusionMatrix = zeros(6,6);


for p = 1:1
testPosition = (Indices == p);
trainPosition = ~testPosition;

trainingset = x(trainPosition,:);
trainingTarget = y(trainPosition,:);
testingset = x(testPosition,:);
testingTarget = y(testPosition,:);

for k = 1:6
    disp(k);
    trainingTarget = (y==k);
    filename =['tree',num2str(k)];
    tree = DecisionTree( trainingset ,trainingTarget);
    eval(['decision_' filename '=tree']);
end

label=zeros(size(testingset,1),1);
for i = 1:size(testingset,1)
    result = [search(testingset(i,:),decision_tree1),search(testingset(i,:),decision_tree2),...
        search(testingset(i,:),decision_tree3),search(testingset(i,:),decision_tree4),...
        search(testingset(i,:),decision_tree5),search(testingset(i,:),decision_tree6)];
    class = find(result == 1);
    
    if (~isempty(class))
        mat = [class',accuracy(class)];
        mat2 = sortrows(mat,-2);
        label(i) = mat2(1,1);
    else
        label(i) = mode(trainingTarget);
    end
end
conmat = confusionmat(double(testingtarget),double(label));
    confusionMatrix = confusionMatrix + conmat;
end