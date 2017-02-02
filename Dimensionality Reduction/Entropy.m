function I = Entropy(labels)

if (length(unique(labels)) == 1)
    I = 0;
    return;
end

positive = length(find(labels==1))/length(labels);
negative = length(find(labels==0))/length(labels);
I = -positive*log2(positive)-negative*log2(negative);