% This function implenments ID3 and return the best feature and best
% threshold.


function [best_feature,best_threshold] = ChooseAttribute(features,targets)

[sampleNum,featureNum]=size(features);


I = Entropy(targets);
featureInfor = 0;
best_feature =1;
best_threshold = 1;
for i=1:featureNum
    
    data = features(:,i);
    inforMax=0;
    feature_threshold = 0;
    for k =1:sampleNum-1
        
        threshold = data(k);
        class1=find(data <= threshold);
        itemLabel1 = targets(class1);
        I1 = Entropy(itemLabel1);
        class2 = find(data > threshold);
        itemLabel2 = targets(class2);
        I2 = Entropy(itemLabel2);
        inforGain = I-(length(class1)/sampleNum)*I1-(length(class2)/sampleNum)*I2;
        if inforGain > inforMax
            inforMax = inforGain;
            feature_threshold = k;
        end
    end
    
    if inforMax > featureInfor
        featureInfor = inforMax;
        best_feature = i;
        best_threshold = feature_threshold;
    end
end
