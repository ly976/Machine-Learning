function [new,feature_attribute, BestFeature] = CFS_features(x,label)

original = x;
k=1;
new=[];
newCFS =[];
sum_cf = 0;
sum_ff =0;
CFS_value = 0;
best_CFS = 0;
feature_attribute=[];
while (best_CFS - CFS_value >= 0)
    CFS_value = best_CFS;
    best_CFS = 0;
    best_cf = 0;
    best_ff = 0;
    bestfeature = 0;
    for i = 1:size(original,2)
        current_cf = sum_cf;
        current_ff = sum_ff;
        feature = original(:,i);
        
        pearson_coeff = Pearson(feature,label);
        current_cf = current_cf + pearson_coeff;
        
        current_sum = 0;
        for p = 1:size(new,2)
            current_sum = current_sum + Pearson(feature, new(:,p));
        end
        current_ff = current_ff + current_sum;
        
        current_CFS = current_cf/sqrt(k+2*current_ff);
        if current_CFS > best_CFS
            best_CFS = current_CFS;
            bestfeature = i;
            best_cf = current_cf;
            best_ff = current_ff;
        end
    end
    data = [bestfeature;pearson_coeff];
    feature_attribute = [feature_attribute,data];
    sum_ff = best_ff;
    sum_cf = best_cf;
    new = [new,original(:,bestfeature)];
    newCFS = [newCFS,best_CFS];
    original(:,bestfeature)=[];
    k=k+1;
end

for index = 1:size(new,2)
    feature = new(:,index);
    current_sum = 0;
    for p = 1:size(new,2)
        current_sum = current_sum + Pearson(feature, new(:,p));
    end
    feature_attribute(3,index) = current_sum;
    feature_attribute(4,index) = feature_attribute(2,index)/feature_attribute(3,index);
end

sorted = sortrows(feature_attribute',-4);
BestFeature = sorted(1,1);

