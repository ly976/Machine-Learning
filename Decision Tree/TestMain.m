load('emotions_data.mat');
load('accuarcy.mat');

confusionMatrix = zeros(6,6);
output = zeros(size(x,1),1);
for i = 1:size(x,1)
    result = [search(x(i,:),decision_tree1),search(x(i,:),decision_tree2),...
        search(x(i,:),decision_tree3),search(x(i,:),decision_tree4),...
        search(x(i,:),decision_tree5),search(x(i,:),decision_tree6)];
    class = find(result == 1);
    if (~isempty(class))
        mat = [class',accuracy(class)];
        mat2 = sortrows(mat,-2);
        output(i) = mat2(1,1);
    else
        output(i) = mode(y);
    end
end
conmat = confusionmat(double(y),double(output));