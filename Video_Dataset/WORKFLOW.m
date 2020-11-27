function WORKFLOW()
matrix=[];
diagram=[];
ent=[];

%suma_total=zeros(24,60);
count=1;
pathname= 'C:\EmotionalRecognition\Partes\test\barcode\Barcode';
pathname_entropy= 'C:\EmotionalRecognition\Partes\test\entropy\Entropy';
for j=8:8 

    for i=23:60
       mkdir([pathname,sprintf('_%d',j)]);
       pathname1=fullfile([pathname,sprintf('_%d',j)],'\');
       mkdir([pathname_entropy,sprintf('_%d',j)]);
       pathname2 = fullfile([pathname_entropy,sprintf('_%d',j)],'\');
       matFileName = sprintf('C:/EmotionalRecognition/Partes/test/Complejos/Complejos_Actor_%d/Complejos_Actor_%d%d.mat',j,j, i);
       indexFileName = sprintf('C:/EmotionalRecognition/Partes/test/Index/Index_Actor_%d/Index_Actor_%d%d.mat',j,j, i);
       Complejo=importdata(matFileName);
       Index= importdata(indexFileName);
       
       for k=1:8
           matrix = complex2matrix(Complejo{k});
      
           [cc]= Persistence_new(matrix);
           cc=sortrows(cc,1);
           all=1:length(matrix);
           missing=setdiff(all,cc(:,1))';
           missing(:,2)=0;
           dd= sortrows([cc;missing],1);
           ii= Index{k};
           ii=[0,ii]';           
           for h=1:length(dd)
              dd(h,1)=max(cumsum((ii-dd(h,1)<0)));
              dd(h,2)=max(cumsum((ii-dd(h,2)<0)));
           end
              dd(dd(:, 2)== 0, :)= [];
              dd(dd(:, 1)== dd(:, 2), :)= [];
            [entropy] = per_entropy(dd);
            diagram{k}=dd;
            ent{k}=entropy;
           
            %suma_total(j,i)= sum([ent{:}]);
            diagram;
            ent;
       end
         
      
    
         Name_diagram = [ pathname1,sprintf('Barcode_diagrama_%d', j)];
         Name_ent = [ pathname2,sprintf('Entropy_entropy_%d', j)];
     
         
         save([ Name_diagram num2str(i) '.mat'],'diagram')
         save([ Name_ent num2str(i) '.mat'],'ent')
     
      clearvars -except  count  j i  Name_ent Name_diagram pathname pathname_entropy suma_total

    end
 count=count+1    
end
end


