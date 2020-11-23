function [index_cuad, complejo]= complex_wtsquare(complejo)

%with this function we are going to split the complexes which form 
%every square to see the features which born and died in the same
%square on complex, later the components which survived get the index where
%square are. 


index_cuad=[];

for i=1:length(complejo)
    if numel(complejo{i})==4
    index_cuad=[index_cuad i];
    end
    
end


  complejo(index_cuad)=[]; 



end



