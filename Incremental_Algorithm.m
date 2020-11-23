function [index_cuad, index_ver, barcode] = Incremental_Algorithm(complejo)
%salida barcode

[index_cuad, index_ver, complejo]= complex_wtsquare(complejo);

borde = BorderOperator(complejo);


n=size(borde,2);
f= sparse(n,n);   
m=sparse(n,n);

% for i=1 : n   %convert f(1)                          
%     f(i,i)=1;    
% end


%INCREMENTAL ALGORITHM. 
count1=0;
for j=1:n
 for i=j+1:n

  A=borde(:,i)-borde(:,j);
  f(j,i)= nnz(A);
 end   
count1=count1+1
end

 for i=1:n
   for j=1:n
       if f(i,j)==1
         m(i,j)=j;
       else
         m(i,j)=0;
       end
   end
end

%out = m - diag(diag(m));

%out( 5 : end,: ) = [];

c=zeros(size(m,1),2);
     
     
for i=size(m,1):-1:1
    
  if i==size(m,1)
      if sum(m(i,:))~=0
          c(i,1)=[i];
          c(i,2)= [find(m(i,:)>0,1)];
      else
           c(i,1)=[i];
           c(i,2)= [size(m,2)+1];
      end
     
  else  
  m(i,:)= abs(m(i+1,:)-m(i,:));
       if sum(m(i,:))~=0
          c(i,1)=[i];
          c(i,2)=[find(m(i,:)>0,1)];
        else
           c(i,1)=[i];
           c(i,2)= [size(m,2)+1];
        end
  end
end
  
for i=1:size(c,1)
 for j=2:size(c,1)
       if c(i,2)==c(j,1)
           c(j,:)=0;
       end
 end
end


barcode=c;
end


    