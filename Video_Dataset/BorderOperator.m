%Obtaining the boundary operator of P(I)

function [borderOperator] = BorderOperator(complejo)
  
   borde = sparse( length(complejo),length(complejo)); 
      sumedge = 0; 
          for i =1 :size(complejo,2)
             sumedge = sumedge +  size(complejo{i},2);
          end
  
     indi = 1;
     
    
     aristas = zeros(sumedge,2);  % sparse
    % aristas = zeros(sumedge,4);
     for i =1 : size(complejo,2)
       
        p = complejo{i}; 
       
        p(1,end+1)= complejo{i}(1);
       
        for j =1 : size(p,2)-1
            v1 = p(1,j); v2 = p(1,j+1); 
            aristas(indi,:) = sort([v1 v2]);
            indi=indi+1;
        end
       p=[];
     end
     
     aristas=unique(aristas,'rows','stable');
   
     if(~isempty(find(aristas==0,1,'first')))
      aristas(find(aristas==0,1,'first'):end)=[];
     end
      vertexes = sort(unique(aristas));
    
     sumaris = zeros( size(aristas,1),1);  %sparse
     for i=1 : size(aristas,1)
      sumaris(i,1) = str2num(strcat(num2str(aristas(i,1)),'0',num2str(aristas(i,2))));
     end  
     
     for i=1 : size(aristas,1)
        v1 = aristas(i,1);
        v2 = aristas(i,2);
       
        borde(v1,i) = 1;   
        borde(v2,i) = 1;  
        
     end
    borderOperator = borde;
   

end
 
%% full to see the matrix

