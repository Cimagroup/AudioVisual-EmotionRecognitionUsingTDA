
function matrix = complex2matrix(complex)

s = cellfun(@(x) size(x,2),complex);
dim = unique(s);
matrix = ones(size(s,2),3)*-1;

for i=1:size(complex,2)
 if(s(i)==1)
     matrix(i,1) = complex{i};
 end
 v =  complex{i};
 f=0;
 if(size(v,2)==2)
  f = (~isempty(find(v==1)) && ~isempty(find(v==37))); end
 if(s(i)==2)
     v =  complex{i};
     in1 = 0;inn2=0;
     con = 0;
     for j=i-1:-1:1
       if(size(complex{j},2)==1 && v(1,1)==complex{j} )
           matrix(i,1) = j-1;
           con = con + 1;
       end
       if(size(complex{j},2)==1 && v(1,2)==complex{j} )
           matrix(i,2) = j-1;
           con = con + 1;
       end
       if(con==2)
           con = 0;
           break;
       end
         
     end
 end
 
 if(s(i)==3)
     v =  complex{i};
     in1 = 0;inn2=0;
     con = 0;
     for j=i-1:-1:1
       if(size(complex{j},2)==2 && ( ~isempty(find(v(1,1)==complex{j})) && ~isempty(find(v(1,2)==complex{j})) ))
           matrix(i,1) = j-1;
           con = con + 1;
       end
       if(size(complex{j},2)==2 && ( ~isempty(find(v(1,1)==complex{j})) && ~isempty(find(v(1,3)==complex{j})) ) )
           matrix(i,2) = j-1;
           con = con + 1;
       end
       if(size(complex{j},2)==2 && ( ~isempty(find(v(1,2)==complex{j})) && ~isempty(find(v(1,3)==complex{j})) ) )
           matrix(i,3) = j-1;
           con = con + 1;
       end
       if(con==3)
           con = 0;
           break;
       end
         
     end
 end   
end

end