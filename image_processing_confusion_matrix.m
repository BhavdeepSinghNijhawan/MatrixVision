clc;
clear all;
close all;
warning off;
M = readtable('M.txt');
J = readtable('J.txt');
V = readtable('V.txt');
plot(M.Var2, M.Var3);
axis equal;
figure;
plot(J.Var2, J.Var3);
axis equal;
figure;
plot(V.Var2, V.Var3);
axis equal;
durM = M.Var1(end);
durJ = J.Var1(end);
durV = V.Var1(end);
aratioM = range(M.Var3) / range(M.Var2);
aratioJ = range(J.Var3) / range(J.Var2);
aratioV = range(V.Var3) / range(V.Var2);
figure;
features = readtable('Features.txt'); % Read features from file
gscatter(features.Var1, features.Var2, features.Var3);
knnmodel = fitcknn(features, 'Var3');
testdata = readtable('testdata.txt');
predictions = predict(knnmodel, testdata(:, 1:2));
Observation = [testdata(:, end) predictions];
knnmodel = fitcknn(features, 'Var3', 'NumNeighbors', 5);
predictions = predict(knnmodel, testdata(:, 1:2));
Observation = [testdata(:, end) predictions];
iscorrect = string(predictions) == string(testdata.Var3);
accuracy = sum(iscorrect) / numel(iscorrect);
misclassrate = sum(~iscorrect) / numel(iscorrect);
disp(['Accuracy: ', num2str(accuracy)]);
disp(['Misclassification Rate: ', num2str(misclassrate)]);
figure;
confusionchart(testdata.Var3, predictions);
