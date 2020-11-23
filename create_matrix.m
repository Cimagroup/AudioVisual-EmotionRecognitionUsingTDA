matrix = [];
for j=1:24
    for i=1:60
        matFileName= sprintf('C:/EmotionalRecognition/Partes/face/entropy/Entropy_%d/Entropy_entropy_%d%d.mat', j, j, i)
        entropy = cell2mat(importdata(matFileName));
        matrix= [matrix,entropy];
    end
end
matrix1= reshape(matrix,[60*24,8]);

 female = matrix1(2:2:end,:);
 male = matrix1(1:2:end,:);


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
total_female = [female, a];
total_male = [male, a];

%total_female(2:2:end,:) = []

matrix_total = [matrix1,a];
%indices = find(matrix_total(:,9)==1);
%matrix_total(indices,:) = [];
matrix_test = [];
matrix_validate = [];
matrix_train = [];
for i=1:24
    matrix_train = [matrix_train ; matrix_total((2+(60*(i-1))):(3+(60*(i-1))),:);
    matrix_total(6+(60*(i-1)): (11+(60*(i-1))),:);
    matrix_total(14 +(60*(i-1)):(19+(60*(i-1))),:);
    matrix_total(22+(60*(i-1)) : (27+(60*(i-1))),:);
    matrix_total(30+(60*(i-1)): (35+(60*(i-1))),:);
    matrix_total(38+(60*(i-1)): (43+(60*(i-1))),:);
    matrix_total(46+(60*(i-1)): (51+(60*(i-1))),:);
    matrix_total(54+(60*(i-1)): (58+(60*(i-1))),:);
    matrix_total(60+(60*(i-1)),:)]
end

    matrix_validate = [ matrix_validate; matrix_total(4+(60*(i-1)),:)];
    matrix_total(12+(60*(i-1)),:);
    matrix_total(20+(60*(i-1)),:);
    matrix_total(28+(60*(i-1)),:);
    matrix_total(36+(60*(i-1)),:);
    matrix_total(44+(60*(i-1)),:);
    matrix_total(51+(60*(i-1)),:);
    matrix_total(59+(60*(i-1)),:)

matrix_entropy1 = matrix_total
matrix_entropy1(:, 3:8)= []
indices1 = find(matrix_entropy1(:,3)==2)
indices2 = find(matrix_entropy1(:,3)==3)
indices3 = find(matrix_entropy1(:,3)==4)
indices4 = find(matrix_entropy1(:,3)==5)
indices5 = find(matrix_entropy1(:,3)==6)
indices6 = find(matrix_entropy1(:,3)==7)
indices7 = find(matrix_entropy1(:,3)==8)
M = [reshape(matrix_entropy1(indices1,1:2)',1,[]); reshape(matrix_entropy1(indices2,1:2)',1,[]); reshape(matrix_entropy1(indices3,1:2)',1,[]); reshape(matrix_entropy1(indices4,1:2)',1,[]); reshape(matrix_entropy1(indices5,1:2)',1,[]); reshape(matrix_entropy1(indices6,1:2)',1,[]);  reshape(matrix_entropy1(indices7,1:2)',1,[])]; 
M = [M;[1;2;3;4;5;6;7]]