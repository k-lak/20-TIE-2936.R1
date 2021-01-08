function [time,...
    output,...
    controlSignal,...
    referenceValue,...
    controlError,...
    extendedStateEstimate] = loadData(fileNumber)
 
    fileName = num2str(fileNumber)+".csv";
    tableData = readtable(fileName,'HeaderLines',25);
    
    time = table2array(tableData(:,2));
    output = table2array(tableData(:,6));
    controlSignal = table2array(tableData(:,8));
    referenceValue = table2array(tableData(:,5));
    controlError = table2array(tableData(:,7));
    
    experimentsUsingP1 = [1 2 3 10 11 12 19 20 21 28 29 30 37 38 39 46 47 48 55 56 57, 66 69 72 75 78 81 84 87 97 90 93 96 99, 127:129];
    experimentsUsingP2 = [[1 2 3 10 11 12 19 20 21 28 29 30 37 38 39 46 47 48 55 56 57]+3, [66 69 72 75 78 81 84 87 97 90 93 96 99]+1, [102 104 106 108 110], 64 65, 112:126, 130:132];
    experimentsUsingP3 = [[1 2 3 10 11 12 19 20 21 28 29 30 37 38 39 46 47 48 55 56 57]+6, [66 69 72 75 78 81 84 87 97 90 93 96 99]+2,[102 104 106 108 110]+1,133:135];
    
    estimatedFirstObserverStageStateP1 = table2array(tableData(:,11:13));
    estimatedFirstObserverStageStateP2 = table2array(tableData(:,14:16));
    estimatedSecondObserverStageStateP2 = table2array(tableData(:,17:19));
    estimatedFirstObserverStageStateP3 = table2array(tableData(:,20:22));
    estimatedSecondObserverStageStateP3 = table2array(tableData(:,23:25));
    estimatedThirdObserverStageStateP3 = table2array(tableData(:,26:28));
    
    if(sum(fileNumber == experimentsUsingP1) == 1)
        extendedStateEstimate = estimatedFirstObserverStageStateP1;
    elseif(sum(fileNumber == experimentsUsingP2) == 1)
        extendedStateEstimate = estimatedSecondObserverStageStateP2 +...
            [zeros(numel(estimatedFirstObserverStageStateP1(:,1)),2), estimatedFirstObserverStageStateP2(:,3)];
    elseif(sum(fileNumber == experimentsUsingP3) == 1)
        extendedStateEstimate = estimatedThirdObserverStageStateP3 +...
            [zeros(numel(estimatedFirstObserverStageStateP3(:,1)),2), estimatedSecondObserverStageStateP3(:,3)]+...
            [zeros(numel(estimatedFirstObserverStageStateP3(:,1)),2), estimatedFirstObserverStageStateP3(:,3)];
    else
        warning('Wrong calculation of extended state');
    end
end

