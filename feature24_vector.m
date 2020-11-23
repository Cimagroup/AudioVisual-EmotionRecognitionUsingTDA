function [training, test] = feature24_vector

matrix = [];
for j=1:24
    for i=1:60
        matFileName= sprintf('C:/EmotionalRecognition/Partes/face/entropy/Entropy_%d/Entropy_entropy_%d%d.mat', j, j, i);
        entropy = cell2mat(importdata(matFileName));
        matrix= [matrix,entropy];
    end
end
matrix1= reshape(matrix,[60*24,8]);

for i=1:24
    a(1+(60*(i-1)):4 + (60*(i-1)),:) = 1;
    a(5+(60*(i-1)):12+(60*(i-1)),:)= 2;
    a(13+(60*(i-1)):20+(60*(i-1)),:) = 3;
    a(21+(60*(i-1)):28+(60*(i-1)),:) = 4;
    a(29+(60*(i-1)):36+(60*(i-1)),:)=5;
    a(37+(60*(i-1)):44+(60*(i-1)),:)=6;
    a(45+(60*(i-1)):52+(60*(i-1)),:)=7;
    a(53+(60*(i-1)):60+(60*(i-1)),:)=8;
end    

matrix_total = [matrix1,a];

indices1 = find(matrix_total(:,9)==1);
indices2 = find(matrix_total(:,9)==2);
indices3 = find(matrix_total(:,9)==3);
indices4 = find(matrix_total(:,9)==4);
indices5 = find(matrix_total(:,9)==5);
indices6 = find(matrix_total(:,9)==6);
indices7 = find(matrix_total(:,9)==7);
indices8 = find(matrix_total(:,9)==8);

test = [];
training = [];

for i=1:8
    F1 = reshape(matrix_total(:,i),[60,24]);
    F1 = [F1,a(1:60)];
    indices1 = find(F1(:,25)==1);
    indices2 = find(F1(:,25)==2);
    indices3 = find(F1(:,25)==3);
    indices4 = find(F1(:,25)==4);
    indices5 = find(F1(:,25)==5);
    indices6 = find(F1(:,25)==6);
    indices7 = find(F1(:,25)==7);
    indices8 = find(F1(:,25)==8);

    test = [test; F1(indices1(1:3:end),:);F1(indices2(1:7:end),:);F1(indices3(1:7:end),:);F1(indices4(1:7:end),:);F1(indices5(1:7:end),:);F1(indices6(1:7:end),:);F1(indices7(1:7:end),:); F1(indices8(1:7:end),:)]
    training = [training; F1(indices1(2:3),:);F1(indices2(2:7),:);F1(indices3(2:7),:);F1(indices4(2:7),:);F1(indices5(2:7),:);F1(indices6(2:7),:);F1(indices7(2:7),:); F1(indices8(2:7),:)]
end
end
