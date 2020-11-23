function [Filters_complex_eigth]= filtracion_complejo(Delaunay_person)
for i=1:10:size(Delaunay_person,2)
delaunay_test{i}= Delaunay_person{1,i}
end

delaunay_test = delaunay_test(~cellfun('isempty',delaunay_test))

for i=1:length(delaunay_test)
        
        Vertex_test{i}=delaunay_test{i}.Points;
        Edges_test{i}=delaunay_test{i}.ConnectivityList;
end

edges=zeros(3*length(Edges_test{1}),2*length(Edges_test));


for i=1:length(Edges_test)
    for j=1:length(Edges_test{i})
    
      edges(1+3*(j-1):3*j,2*i-1:2*i) = nchoosek(Edges_test{i}(j,:),2);
    end
   edges(:,2*i-1)= edges(:,1)+68*(i-1);
   
   edges(:,2*i)= edges(:,2)+68*(i-1);  
end

vertex= zeros(length( Vertex_test{1}),2*length( Vertex_test));
for i=1:length(Vertex_test)
    for j=1:length(Vertex_test{i})
    
      vertex(j,2*i-1:2*i) = Vertex_test{i}(j,:);
    end
     
end


Vertices= zeros((size(edges,2)/2)*68,2);
Vertices(:,1)= [vertex(:,1); vertex(:,3);vertex(:,5); vertex(:,7);vertex(:,9); vertex(:,11);vertex(:,13); vertex(:,15);vertex(:,17)];
Vertices(:,2)= [vertex(:,2); vertex(:,4);vertex(:,6); vertex(:,8);vertex(:,10); vertex(:,12);vertex(:,14); vertex(:,16);vertex(:,18)];

Cuadrados= zeros(size(edges,1)*8,4);
Cuadrados_vertices= zeros(size(vertex,1)*8,4);

for i=1:8
  Cuadrados(size(edges,1)*(i-1)+1:size(edges,1)*i,:)  = edges(:,2*i-1:2*(i+1));
   Cuadrados_vertices(size(vertex,1)*(i-1)+1:size(vertex,1)*i,:)  = vertex(:,2*i-1:2*(i+1));
end

%creando la estrucutra para luego realizar las filtraciones
 complex.pts=Vertices;
 complex.cuad=Cuadrados;

%realizar la filtraciones
 filters = filtrations(complex);
 
for j=1:8 
 for i=1:length(filters.complejoX)
Filters_complex{j}{i}={[filters.complejoX(i,1)], [filters.complejoX(i,2)], [filters.complejoX(i,3)], [filters.complejoX(i,4)], [filters.complejoX(i,1) filters.complejoX(i,2)],  [filters.complejoX(i,3) filters.complejoX(i,4)],[filters.complejoX(i,1) filters.complejoX(i,3)],[filters.complejoX(i,2) filters.complejoX(i,4)], [filters.complejoX(i,1) filters.complejoX(i,2) filters.complejoX(i,3) filters.complejoX(i,4)]};
Filters_complex{j}{i}={[filters.complejoY(i,1)], [filters.complejoY(i,2)], [filters.complejoY(i,3)], [filters.complejoY(i,4)], [filters.complejoY(i,1) filters.complejoY(i,2)],  [filters.complejoY(i,3) filters.complejoY(i,4)],[filters.complejoY(i,1) filters.complejoY(i,3)],[filters.complejoY(i,2) filters.complejoY(i,4)], [filters.complejoY(i,1) filters.complejoY(i,2) filters.complejoY(i,3) filters.complejoY(i,4)]};
Filters_complex{j}{i}={[filters.complejoXY(i,1)], [filters.complejoXY(i,2)], [filters.complejoXY(i,3)], [filters.complejoXY(i,4)], [filters.complejoXY(i,1) filters.complejoXY(i,2)],  [filters.complejoXY(i,3) filters.complejoXY(i,4)],[filters.complejoXY(i,1) filters.complejoXY(i,3)],[filters.complejoXY(i,2) filters.complejoXY(i,4)], [filters.complejoXY(i,1) filters.complejoXY(i,2) filters.complejoXY(i,3) filters.complejoXY(i,4)]};
Filters_complex{j}{i}={[filters.complejoYX(i,1)], [filters.complejoYX(i,2)], [filters.complejoYX(i,3)], [filters.complejoYX(i,4)], [filters.complejoYX(i,1) filters.complejoYX(i,2)],  [filters.complejoYX(i,3) filters.complejoYX(i,4)],[filters.complejoYX(i,1) filters.complejoYX(i,3)],[filters.complejoYX(i,2) filters.complejoYX(i,4)], [filters.complejoYX(i,1) filters.complejoYX(i,2) filters.complejoYX(i,3) filters.complejoYX(i,4)]};
Filters_complex{j}{i}={[filters.complejoX_inv(i,1)], [filters.complejoX_inv(i,2)], [filters.complejoX_inv(i,3)], [filters.complejoX_inv(i,4)], [filters.complejoX_inv(i,1) filters.complejoX_inv(i,2)],  [filters.complejoX_inv(i,3) filters.complejoX_inv(i,4)],[filters.complejoX_inv(i,1) filters.complejoX_inv(i,3)],[filters.complejoX_inv(i,2) filters.complejoX_inv(i,4)], [filters.complejoX_inv(i,1) filters.complejoX_inv(i,2) filters.complejoX_inv(i,3) filters.complejoX_inv(i,4)]};
Filters_complex{j}{i}={[filters.complejoY_inv(i,1)], [filters.complejoY_inv(i,2)], [filters.complejoY_inv(i,3)], [filters.complejoY_inv(i,4)], [filters.complejoY_inv(i,1) filters.complejoY_inv(i,2)],  [filters.complejoY_inv(i,3) filters.complejoY_inv(i,4)],[filters.complejoY_inv(i,1) filters.complejoY_inv(i,3)],[filters.complejoY_inv(i,2) filters.complejoY_inv(i,4)], [filters.complejoY_inv(i,1) filters.complejoY_inv(i,2) filters.complejoY_inv(i,3) filters.complejoY_inv(i,4)]};
Filters_complex{j}{i}={[filters.complejoXY_inv(i,1)], [filters.complejoXY_inv(i,2)], [filters.complejoXY_inv(i,3)], [filters.complejoXY_inv(i,4)], [filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,2)],  [filters.complejoXY_inv(i,3) filters.complejoXY_inv(i,4)],[filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,3)],[filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,4)], [filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,3) filters.complejoXY_inv(i,4)]};
Filters_complex{j}{i}={[filters.complejoYX_inv(i,1)], [filters.complejoYX_inv(i,2)], [filters.complejoYX_inv(i,3)], [filters.complejoYX_inv(i,4)], [filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,2)],  [filters.complejoYX_inv(i,3) filters.complejoYX_inv(i,4)],[filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,3)],[filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,4)], [filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,3) filters.complejoYX_inv(i,4)]};

  end
end


%concantenando todods los cuadrados construidos
%
 Complejo=cell(1,9*numel(example));
 for j=1:8
 for k = 1:numel( Filters_complex{j})
    S =  Filters_complex{j}{k} ;
    Complejo(9*(k-1)+1:9*k) = S;
 end
 Filt_complex{j}=Complejo;
   
 end
 

 %uniendo los complejos para ahora comparar y eliminar los que se repiten
for j=1:8
for i=1: length(Filt_complex{j})
    
    if length(Filt_complex{j}{i})~=1
       b=sscanf(sprintf('%d',Filt_complex{j}{i}),'%lu');
       Complex_join{i}=b;
    else length(Filt_complex{j}{i})==1
        Complex_join{i}=Filt_complex{j}{i};
    
    end
    
end
 Filters_complex_join{j}=Complex_join;
 end

 for j=1:8
[~,jj{j}]=unique(horzcat(Complex_join{1:length( Filters_complex_join{j})}),'stable')
 end
%%jj me devuele las posiciones que debo mantener de mi complejo formado 
%%por los cuadrados

%%aqui obtenemos nuestro complejo con todos los terminos que se repiten
%%eliminados
for j=1:8
for i=1:length(jj{j})
   Filters_complex_eigth{j}{i}= Filt_complex{j}{jj{j}(i)} ;
end
end

end




