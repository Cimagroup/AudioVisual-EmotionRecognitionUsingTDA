function [test, training, training8, test8] = experimento(n)

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
indices = find(matrix_total(:,9)==1);
matrix_total(indices,:) = [];
training8 =[];
test8=[];
for i=1:24
    for j=1:7
    training8 = [training8 ; matrix_total(((1+8*(j-1))+(56*(i-1))):((3+8*(j-1))+(56*(i-1))),:); matrix_total(((6+8*(j-1))+(56*(i-1))):((8+8*(j-1))+(56*(i-1))),:)];
    test8 = [test8; matrix_total(((4+8*(j-1))+(56*(i-1))):((5+8*(j-1))+(56*(i-1))),:)];
    end
end

matrix_total(:,2:8)=[];
%matrix_total(:,1)=[];
test = [];
training= [];
for i=1:24
    for j=1:7
    training = [training ; matrix_total(((1+8*(j-1))+(56*(i-1))):((3+8*(j-1))+(56*(i-1))),:); matrix_total(((6+8*(j-1))+(56*(i-1))):((8+8*(j-1))+(56*(i-1))),:)];
    test = [test; matrix_total(((4+8*(j-1))+(56*(i-1))):((5+8*(j-1))+(56*(i-1))),:)];
    end
end
test = sortrows(test,2);
training = sortrows(training,2);

%idx = randperm(size(Total,1),538);
end