load('emotions_data.mat');

Indices = crossvalind('Kfold',y, 10);

confusionMatrix = zeros(6,6);


for p = 1:10
    testPosition = (Indices == p);
    trainPosition = ~testPosition;
    
    trainingset = x(trainPosition,:);
    trainingTarget = y(trainPosition,:);
    testingset = x(testPosition,:);
    testingTarget = y(testPosition,:);
    
    tree = cell(6,1);
    accuracy = zeros(6,1);
    result = zeros(size(testingset,1),6);
    for k = 1:6
        disp(k);
        label = (trainingTarget==k);
        [newfeature,attribute,bestfeature] = CFS_features(trainingset,label);
        
        tree{k} = DecisionTree(newfeature,label);
        
        array = attribute(1,:);
        c = testingset(:,array);
        newlabel = zeros(length(c),1);
        for i = 1:size(c,1)
            newlabel(i) = search(c(i,:),tree{k},newfeature);
        end
        result(:,k)=newlabel;
        testlabel = (testingTarget==k);
        conmat = confusionmat(double(testlabel),double(newlabel));
        accuracy(k) = sum(diag(conmat))/sum(sum(conmat));
    end
    
      tlabel=zeros(size(testingset,1),1);
      
      for i = 1:size(testingset,1)
          sample = result(i,:);
          class = find(sample == 1);
          if (~isempty(class))
            mat = [class',accuracy(class)];
            mat2 = sortrows(mat,-2);
            tlabel(i) = class(1,1);
          else
            tlabel(i) = mode(trainingTarget);
          end
      end
      conmat = confusionmat(double(testingTarget),double(tlabel));
      confusionMatrix = confusionMatrix + conmat;
end
classification = sum(diag(conmat))/sum(sum(conmat));