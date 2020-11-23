M=full(m_Split{1});
out = M - diag(diag(M));

out( ~any(out,2), : ) = [];

c=zeros(size(out,1),2)
     
     
for i=size(out,1):-1:1
    
  if i==size(out,1)
      if sum(out(i,:))~=0
          c(i,1)=[i];
          c(i,2)= [find(out(i,:)>0,1)];
      else
           c(i,1)=[i];
           c(i,2)= [size(out,2)+1];
      end
     
  else  
  out(i,:)= abs(out(i+1,:)-out(i,:));
       
    
        if sum(out(i,:))~=0
          c(i,1)=[i];
          c(i,2)=[find(out(i,:)>0,1)];
        else
           c(i,1)=[i];
           c(i,2)= [size(out,2)+1];
        end
      
      
        end
end