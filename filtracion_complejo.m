function [Filters_complex_eight_full]= filtracion_complejo(delaunay)

fprintf('\nCounter: ')

  for h=1:24
   for m=1:60
       
    for i=1:2:size(delaunay{h},2)
     delaunay_test{i}= delaunay{h}{m,i};
    end
     delaunay_test = delaunay_test(~cellfun('isempty',delaunay_test));


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
      
      edges(336:339,:) = []
      vertex= zeros(length( Vertex_test{1}),2*length( Vertex_test));
         for i=1:length(Vertex_test)
            for j=1:length(Vertex_test{i})
    
            vertex(j,2*i-1:2*i) = Vertex_test{i}(j,:);
            end
     
         end

       n = size(vertex,1);
       m = size(vertex,2)/2;
       %Vertices= zeros(20*n,2);
       Vertices= zeros(n*m,2);
       A = vertex(:,1:2:end); %odd matrix 
       B = vertex(:,2:2:end);
       %Vertices(:,1)= reshape(A,20*n,1);
       Vertices(:,1)= reshape(A,n*m,1);

       Vertices(:,2)= reshape(B,n*m,1);



      Cuadrados= zeros(size(edges,1)*8,4);
      Cuadrados_vertices= zeros(size(vertex,1)*8,4);

    for i=1:8
    Cuadrados(size(edges,1)*(i-1)+1:size(edges,1)*i,:)  = edges(:,2*i-1:2*(i+1));
   Cuadrados_vertices(size(vertex,1)*(i-1)+1:size(vertex,1)*i,:)  = vertex(:,2*i-1:2*(i+1));
    end


%creando la estrucutra para luego realizar las filtraciones

     Cuadrados= Cuadrados(all(Cuadrados,2),:);

    complex.pts=Vertices;
    complex.cuad=Cuadrados;

%realizar la filtraciones


   filters = filtrations(complex);



    for i=1:length(filters.complejoX)
      Filters_complex{1}{i}={[filters.complejoX(i,1)], [filters.complejoX(i,2)], [filters.complejoX(i,3)], [filters.complejoX(i,4)], [filters.complejoX(i,1) filters.complejoX(i,2)],  [filters.complejoX(i,3) filters.complejoX(i,4)],[filters.complejoX(i,1) filters.complejoX(i,3)],[filters.complejoX(i,2) filters.complejoX(i,4)], [filters.complejoX(i,1) filters.complejoX(i,2) filters.complejoX(i,3) filters.complejoX(i,4)]};
      Filters_complex{2}{i}={[filters.complejoY(i,1)], [filters.complejoY(i,2)], [filters.complejoY(i,3)], [filters.complejoY(i,4)], [filters.complejoY(i,1) filters.complejoY(i,2)],  [filters.complejoY(i,3) filters.complejoY(i,4)],[filters.complejoY(i,1) filters.complejoY(i,3)],[filters.complejoY(i,2) filters.complejoY(i,4)], [filters.complejoY(i,1) filters.complejoY(i,2) filters.complejoY(i,3) filters.complejoY(i,4)]};
      Filters_complex{3}{i}={[filters.complejoXY(i,1)], [filters.complejoXY(i,2)], [filters.complejoXY(i,3)], [filters.complejoXY(i,4)], [filters.complejoXY(i,1) filters.complejoXY(i,2)],  [filters.complejoXY(i,3) filters.complejoXY(i,4)],[filters.complejoXY(i,1) filters.complejoXY(i,3)],[filters.complejoXY(i,2) filters.complejoXY(i,4)], [filters.complejoXY(i,1) filters.complejoXY(i,2) filters.complejoXY(i,3) filters.complejoXY(i,4)]};
      Filters_complex{4}{i}={[filters.complejoYX(i,1)], [filters.complejoYX(i,2)], [filters.complejoYX(i,3)], [filters.complejoYX(i,4)], [filters.complejoYX(i,1) filters.complejoYX(i,2)],  [filters.complejoYX(i,3) filters.complejoYX(i,4)],[filters.complejoYX(i,1) filters.complejoYX(i,3)],[filters.complejoYX(i,2) filters.complejoYX(i,4)], [filters.complejoYX(i,1) filters.complejoYX(i,2) filters.complejoYX(i,3) filters.complejoYX(i,4)]};
      Filters_complex{5}{i}={[filters.complejoX_inv(i,1)], [filters.complejoX_inv(i,2)], [filters.complejoX_inv(i,3)], [filters.complejoX_inv(i,4)], [filters.complejoX_inv(i,1) filters.complejoX_inv(i,2)],  [filters.complejoX_inv(i,3) filters.complejoX_inv(i,4)],[filters.complejoX_inv(i,1) filters.complejoX_inv(i,3)],[filters.complejoX_inv(i,2) filters.complejoX_inv(i,4)], [filters.complejoX_inv(i,1) filters.complejoX_inv(i,2) filters.complejoX_inv(i,3) filters.complejoX_inv(i,4)]};
      Filters_complex{6}{i}={[filters.complejoY_inv(i,1)], [filters.complejoY_inv(i,2)], [filters.complejoY_inv(i,3)], [filters.complejoY_inv(i,4)], [filters.complejoY_inv(i,1) filters.complejoY_inv(i,2)],  [filters.complejoY_inv(i,3) filters.complejoY_inv(i,4)],[filters.complejoY_inv(i,1) filters.complejoY_inv(i,3)],[filters.complejoY_inv(i,2) filters.complejoY_inv(i,4)], [filters.complejoY_inv(i,1) filters.complejoY_inv(i,2) filters.complejoY_inv(i,3) filters.complejoY_inv(i,4)]};
      Filters_complex{7}{i}={[filters.complejoXY_inv(i,1)], [filters.complejoXY_inv(i,2)], [filters.complejoXY_inv(i,3)], [filters.complejoXY_inv(i,4)], [filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,2)],  [filters.complejoXY_inv(i,3) filters.complejoXY_inv(i,4)],[filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,3)],[filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,4)], [filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,3) filters.complejoXY_inv(i,4)]};
      Filters_complex{8}{i}={[filters.complejoYX_inv(i,1)], [filters.complejoYX_inv(i,2)], [filters.complejoYX_inv(i,3)], [filters.complejoYX_inv(i,4)], [filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,2)],  [filters.complejoYX_inv(i,3) filters.complejoYX_inv(i,4)],[filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,3)],[filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,4)], [filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,3) filters.complejoYX_inv(i,4)]};
    end


%concantenando todods los cuadrados construidos
%

     for j=1:8
       Complejo=cell(1,9*numel(Filters_complex{j}));
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
     Filters_complex_eigth;
      end
        Filters_complex_eight_full{h}{m}=Filters_complex_eigth;

            clearvars -except  Delaunay_base  Filters_complex_eight_full delaunay h m
          
       
    end
         fprintf('%d', h); 
  end
fprintf('\n')
end







