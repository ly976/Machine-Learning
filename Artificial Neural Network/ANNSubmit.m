load('emotions_data')
% Set inputs to be x and y transpose
inputs = x';
targets = y';

Indices = crossvalind('Kfold',y', 10);

% Intialising matrices with zeros
confusionMatrix = zeros(6,6);
recallMatrix = zeros(10,6);
precisionMatrix = zeros(10,6);
f1Matrix = zeros(10,6);

% Performing 10 fold cross validation wit the use of a for loop
for i=1:10
    testPosition = (Indices == i); 
    trainPosition = ~testPosition;
    
    trainingset = inputs(:,trainPosition);
    trainingTarget = targets(:,trainPosition);
    testingset = inputs(:,testPosition);
    testingTarget = targets(:,testPosition);
    
    [trainingset,inputps]=mapminmax(trainingset);
    testingset=mapminmax('apply',testingset,inputps);
    
    [trainingTarget,outputps]=mapminmax(trainingTarget);
    
    %trainingset = mapminmax(trainingset,0,1);
    
    %Creating the network
    net = newff(trainingset,trainingTarget,20,{'tansig','tansig'},'trainrp');
    net.trainParam.epochs = 1000;
    net.trainParam.show = 10;
    net.trainParam.lr = 0.01;
    net.trainParam.goal = 0;
    %net.trainParam.goal = 0.00001;
    net = init(net);
    net = train(net,trainingset,trainingTarget);
    outputs = sim(net,testingset);
    outputs=mapminmax('reverse',outputs,outputps);
    outputs1 = round(outputs);
    
    conmat = confusionmat(testingTarget,outputs1);
    recallMatrix(i,:) = diag(conmat)'./sum(conmat,2)';
    precisionMatrix(i,:) = diag(conmat)'./sum(conmat);
    f1Matrix(i,:) = 2*(recallMatrix(i,:).* precisionMatrix(i,:))./ (recallMatrix(i,:)+precisionMatrix(i,:));
    
    confusionMatrix = confusionMatrix + conmat;
end

%Displaying values at the end 
disp(confusionMatrix);
disp(precisionMatrix);
disp(f1Matrix);
accuracy = sum(diag(confusionMatrix))/sum(sum(confusionMatrix));
disp(accuracy);