load('emotions_data.mat');

label = zeros(length(x),1);
accuracy = zeros(6,1);
for i = 1:size(x,1)
    label(i) = search(x(i,:),decision_tree1);
end
target = (y==1);
conmat = confusionmat(double(target),double(label));
accuracy(1) = sum(diag(conmat))/sum(sum(conmat));

label = zeros(length(x),1);
for i = 1:length(x)
    label(i) = search(x(i,:),decision_tree2);
end
target = (y==2);
conmat = confusionmat(double(target),double(label));
accuracy(2) = sum(diag(conmat))/sum(sum(conmat));


label = zeros(length(x),1);
for i = 1:length(x)
    label(i) = search(x(i,:),decision_tree3);
end
target = (y==3);
conmat = confusionmat(double(target),double(label));
accuracy(3) = sum(diag(conmat))/sum(sum(conmat));


label = zeros(length(x),1);
for i = 1:length(x)
    label(i) = search(x(i,:),decision_tree4);
end
target = (y==4);
conmat = confusionmat(double(target),double(label));
accuracy(4) = sum(diag(conmat))/sum(sum(conmat));

label = zeros(length(x),1);
for i = 1:length(x)
    label(i) = search(x(i,:),decision_tree5);
end
target = (y==5);
conmat = confusionmat(double(target),double(label));
accuracy(5) = sum(diag(conmat))/sum(sum(conmat));


label = zeros(length(x),1);
for i = 1:length(x)
    label(i) = search(x(i,:),decision_tree6);
end
target = (y==6);
conmat = confusionmat(double(target),double(label));
accuracy(6) = sum(diag(conmat))/sum(sum(conmat));

save accuarcy;