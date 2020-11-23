%%% the input is the Delaunay triangulation, in this code we built the
%%% complexes using the trinagulation, taking the edges which forms the
%%% squares and used them to form the square in every frame. We are working
%%% with 9 frames

function complex_filtration(delaunay)
%function [Filters_complex_eight_full]= complex_filtration(delaunay)
pathname= 'C:\EmotionalRecognition\Partes\face\Complejos\Complejos';
pathname_index= 'C:\EmotionalRecognition\Partes\face\Index\Index';
Complex_eight_full=[];
Index_eight_full=[];
delaunay_test=[];
  for h=1:24
  mkdir([pathname,sprintf('_Actor_%d',h)]);
  pathname1=fullfile([pathname,sprintf('_Actor_%d',h)],'\');
  mkdir([pathname_index,sprintf('_Actor_%d',h)]);
  pathname2 = fullfile([pathname_index,sprintf('_Actor_%d',h)],'\');

   for m=1:60
    for i=1:size(delaunay{h},2)
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




             vertex= zeros(length( Vertex_test{1}),2*length( Vertex_test));
         for i=1:length(Vertex_test)
            for j=1:length(Vertex_test{i})
    
            vertex(j,2*i-1:2*i) = Vertex_test{i}(j,:);
            end
     
         end


        Vertices= zeros(size(vertex,1)*size(delaunay{h},2),2);
        A = vertex(:,1:2:end); %odd matrix 
        B = vertex(:,2:2:end);
        Vertices(:,1)= reshape(A,size(vertex,1)*size(delaunay{h},2),1);
        Vertices(:,2)= reshape(A,size(vertex,1)*size(delaunay{h},2),1);
 

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
      Filters_complex{6}{i}={[filters.complejoY_inv(i,1)], [filters.complejoY_inv(i,2)], [filters.complejoY_inv(i,3)], [filters.complejoY_inv(i,4)], [filters.complejoY_inv(i,1) filters.complejoY_inv(i,2)],  [filters.complejoY_inv(i,3) filters.complejoY_inv(i,4)],[filters.complejoY_inv(i,1) filters.complejoY_inv(i,3)],[filters.complejoY_inv(i,2) filters.complejoY_inv(i,4)], [filters.complejoX_inv(i,1) filters.complejoY_inv(i,2) filters.complejoY_inv(i,3) filters.complejoY_inv(i,4)]};
      Filters_complex{7}{i}={[filters.complejoXY_inv(i,1)], [filters.complejoXY_inv(i,2)], [filters.complejoXY_inv(i,3)], [filters.complejoXY_inv(i,4)], [filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,2)],  [filters.complejoXY_inv(i,3) filters.complejoXY_inv(i,4)],[filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,3)],[filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,4)], [filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,3) filters.complejoXY_inv(i,4)]};
      Filters_complex{8}{i}={[filters.complejoYX_inv(i,1)], [filters.complejoYX_inv(i,2)], [filters.complejoYX_inv(i,3)], [filters.complejoYX_inv(i,4)], [filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,2)],  [filters.complejoYX_inv(i,3) filters.complejoYX_inv(i,4)],[filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,3)],[filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,4)], [filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,3) filters.complejoYX_inv(i,4)]};
    end


%     for i=1:length(filters.complejoX)
%       Filters_complex{1}{i}={[filters.complejoX(i,1)], [filters.complejoX(i,2)], [filters.complejoX(i,3)],  [filters.complejoX(i,1) filters.complejoX(i,2)],[filters.complejoX(i,1) filters.complejoX(i,3)],[filters.complejoX(i,2) filters.complejoX(i,3)], [filters.complejoX(i,1) filters.complejoX(i,2) filters.complejoX(i,3)], [filters.complejoX(i,4)], [filters.complejoX(i,2) filters.complejoX(i,4)],[filters.complejoX(i,3) filters.complejoX(i,4)],[filters.complejoX(i,2) filters.complejoX(i,3) filters.complejoX(i,4)]};
%       Filters_complex{2}{i}={[filters.complejoY(i,1)], [filters.complejoY(i,2)], [filters.complejoY(i,3)],  [filters.complejoY(i,1) filters.complejoY(i,2)],[filters.complejoY(i,1) filters.complejoY(i,3)],[filters.complejoY(i,2) filters.complejoY(i,3)], [filters.complejoY(i,1) filters.complejoY(i,2) filters.complejoY(i,3)], [filters.complejoY(i,4)], [filters.complejoY(i,2) filters.complejoY(i,4)],[filters.complejoY(i,3) filters.complejoY(i,4)],[filters.complejoY(i,2) filters.complejoY(i,3) filters.complejoY(i,4)]};
%       Filters_complex{3}{i}={[filters.complejoXY(i,1)], [filters.complejoXY(i,2)], [filters.complejoXY(i,3)],  [filters.complejoXY(i,1) filters.complejoXY(i,2)],[filters.complejoXY(i,1) filters.complejoXY(i,3)],[filters.complejoXY(i,2) filters.complejoXY(i,3)], [filters.complejoXY(i,1) filters.complejoXY(i,2) filters.complejoXY(i,3)], [filters.complejoXY(i,4)], [filters.complejoXY(i,2) filters.complejoXY(i,4)],[filters.complejoXY(i,3) filters.complejoXY(i,4)],[filters.complejoXY(i,2) filters.complejoXY(i,3) filters.complejoXY(i,4)]};
%       Filters_complex{4}{i}={[filters.complejoYX(i,1)], [filters.complejoYX(i,2)], [filters.complejoYX(i,3)],  [filters.complejoYX(i,1) filters.complejoYX(i,2)],[filters.complejoYX(i,1) filters.complejoYX(i,3)],[filters.complejoYX(i,2) filters.complejoYX(i,3)], [filters.complejoYX(i,1) filters.complejoYX(i,2) filters.complejoYX(i,3)], [filters.complejoYX(i,4)], [filters.complejoYX(i,2) filters.complejoYX(i,4)],[filters.complejoYX(i,3) filters.complejoYX(i,4)],[filters.complejoYX(i,2) filters.complejoYX(i,3) filters.complejoYX(i,4)]};
%       Filters_complex{5}{i}={[filters.complejoX_inv(i,1)], [filters.complejoX_inv(i,2)], [filters.complejoX_inv(i,3)],  [filters.complejoX_inv(i,1) filters.complejoX_inv(i,2)],[filters.complejoX_inv(i,1) filters.complejoX_inv(i,3)],[filters.complejoX_inv(i,2) filters.complejoX_inv(i,3)], [filters.complejoX_inv(i,1) filters.complejoX_inv(i,2) filters.complejoX_inv(i,3)], [filters.complejoX_inv(i,4)], [filters.complejoX_inv(i,2) filters.complejoX_inv(i,4)],[filters.complejoX_inv(i,3) filters.complejoX_inv(i,4)],[filters.complejoX_inv(i,2) filters.complejoX_inv(i,3) filters.complejoX_inv(i,4)]};
%       Filters_complex{6}{i}={[filters.complejoY_inv(i,1)], [filters.complejoY_inv(i,2)], [filters.complejoY_inv(i,3)],  [filters.complejoY_inv(i,1) filters.complejoY_inv(i,2)],[filters.complejoY_inv(i,1) filters.complejoY_inv(i,3)],[filters.complejoY_inv(i,2) filters.complejoY_inv(i,3)], [filters.complejoY_inv(i,1) filters.complejoY_inv(i,2) filters.complejoY_inv(i,3)], [filters.complejoY_inv(i,4)], [filters.complejoY_inv(i,2) filters.complejoY_inv(i,4)],[filters.complejoY_inv(i,3) filters.complejoY_inv(i,4)],[filters.complejoY_inv(i,2) filters.complejoY_inv(i,3) filters.complejoY_inv(i,4)]};
%       Filters_complex{7}{i}={[filters.complejoXY_inv(i,1)], [filters.complejoXY_inv(i,2)], [filters.complejoXY_inv(i,3)],  [filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,2)],[filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,3)],[filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,3)], [filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,3)], [filters.complejoXY_inv(i,4)], [filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,4)],[filters.complejoXY_inv(i,3) filters.complejoXY_inv(i,4)],[filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,3) filters.complejoXY_inv(i,4)]};
%       Filters_complex{8}{i}={[filters.complejoYX_inv(i,1)], [filters.complejoYX_inv(i,2)], [filters.complejoYX_inv(i,3)],  [filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,2)],[filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,3)],[filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,3)], [filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,3)], [filters.complejoYX_inv(i,4)], [filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,4)],[filters.complejoYX_inv(i,3) filters.complejoYX_inv(i,4)],[filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,3) filters.complejoYX_inv(i,4)]};
% 
%     end

%       Filters_complex{2}{i}={[filters.complejoY(i,1)], [filters.complejoY(i,2)], [filters.complejoY(i,3)], [filters.complejoY(i,4)], [filters.complejoY(i,1) filters.complejoY(i,2)],  [filters.complejoY(i,3) filters.complejoY(i,4)],[filters.complejoY(i,1) filters.complejoY(i,3)],[filters.complejoY(i,2) filters.complejoY(i,4)], [filters.complejoY(i,2) filters.complejoY(i,3)], [filters.complejoY(i,1) filters.complejoY(i,2) filters.complejoY(i,3)],[filters.complejoY(i,2) filters.complejoY(i,3) filters.complejoY(i,4)]};
%       Filters_complex{3}{i}={[filters.complejoXY(i,1)], [filters.complejoXY(i,2)], [filters.complejoXY(i,3)], [filters.complejoXY(i,4)], [filters.complejoXY(i,1) filters.complejoXY(i,2)],  [filters.complejoXY(i,3) filters.complejoXY(i,4)],[filters.complejoXY(i,1) filters.complejoXY(i,3)],[filters.complejoXY(i,2) filters.complejoXY(i,4)],[filters.complejoXY(i,2) filters.complejoXY(i,3)], [filters.complejoXY(i,1) filters.complejoXY(i,2) filters.complejoXY(i,3)],[filters.complejoXY(i,2) filters.complejoXY(i,3) filters.complejoXY(i,4)]};
%       Filters_complex{4}{i}={[filters.complejoYX(i,1)], [filters.complejoYX(i,2)], [filters.complejoYX(i,3)], [filters.complejoYX(i,4)], [filters.complejoYX(i,1) filters.complejoYX(i,2)],  [filters.complejoYX(i,3) filters.complejoYX(i,4)],[filters.complejoYX(i,1) filters.complejoYX(i,3)],[filters.complejoYX(i,2) filters.complejoYX(i,4)],[filters.complejoYX(i,2) filters.complejoYX(i,3)], [filters.complejoYX(i,1) filters.complejoYX(i,2) filters.complejoYX(i,3)],[filters.complejoYX(i,2) filters.complejoYX(i,3) filters.complejoYX(i,4)]};
%       Filters_complex{5}{i}={[filters.complejoX_inv(i,1)], [filters.complejoX_inv(i,2)], [filters.complejoX_inv(i,3)], [filters.complejoX_inv(i,4)], [filters.complejoX_inv(i,1) filters.complejoX_inv(i,2)],  [filters.complejoX_inv(i,3) filters.complejoX_inv(i,4)],[filters.complejoX_inv(i,1) filters.complejoX_inv(i,3)],[filters.complejoX_inv(i,2) filters.complejoX_inv(i,4)],[filters.complejoX_inv(i,2) filters.complejoX_inv(i,3)], [filters.complejoX_inv(i,1) filters.complejoX_inv(i,2) filters.complejoX_inv(i,3)],[filters.complejoX_inv(i,2) filters.complejoX_inv(i,3) filters.complejoX_inv(i,4)]};
%       Filters_complex{6}{i}={[filters.complejoY_inv(i,1)], [filters.complejoY_inv(i,2)], [filters.complejoY_inv(i,3)], [filters.complejoY_inv(i,4)], [filters.complejoY_inv(i,1) filters.complejoY_inv(i,2)],  [filters.complejoY_inv(i,3) filters.complejoY_inv(i,4)],[filters.complejoY_inv(i,1) filters.complejoY_inv(i,3)],[filters.complejoY_inv(i,2) filters.complejoY_inv(i,4)],[filters.complejoY_inv(i,2) filters.complejoY_inv(i,3)], [filters.complejoY_inv(i,1) filters.complejoY_inv(i,2) filters.complejoY_inv(i,3)],[filters.complejoY_inv(i,2) filters.complejoY_inv(i,3) filters.complejoY_inv(i,4)]};
%       Filters_complex{7}{i}={[filters.complejoXY_inv(i,1)], [filters.complejoXY_inv(i,2)], [filters.complejoXY_inv(i,3)], [filters.complejoXY_inv(i,4)], [filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,2)],  [filters.complejoXY_inv(i,3) filters.complejoXY_inv(i,4)],[filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,3)],[filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,4)], [filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,3)], [filters.complejoXY_inv(i,1) filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,3)],[filters.complejoXY_inv(i,2) filters.complejoXY_inv(i,3) filters.complejoXY_inv(i,4)]};
%       Filters_complex{8}{i}={[filters.complejoYX_inv(i,1)], [filters.complejoYX_inv(i,2)], [filters.complejoYX_inv(i,3)], [filters.complejoYX_inv(i,4)], [filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,2)],  [filters.complejoYX_inv(i,3) filters.complejoYX_inv(i,4)],[filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,3)],[filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,4)],[filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,3)], [filters.complejoYX_inv(i,1) filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,3)],[filters.complejoYX_inv(i,2) filters.complejoYX_inv(i,3) filters.complejoYX_inv(i,4)]};
% 
% 
%     end




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

        for j=1:8
           A=Filt_complex{j};
           t=max(cellfun(@numel,A));
           v=cellfun(@(x) [x  inf(1,t-numel(x))],A,'un',0);
           [~,ii]=unique(cell2mat(v'),'rows','stable');
           A=A(ii);
           
           [index_cuad, complejo]= complex_wtsquare(A);
           complex_eigth{j}=complejo;
          %   complex_eigth{j}=A;
            Index_cuad{j}=index_cuad;
            complex_eigth;
           % Filters_complex_eigth{j}=A;
        end
     
        Name_complejos = [pathname1,sprintf('Complejos_Actor_%d', h)];
        Name_index = [pathname2,sprintf('Index_Actor_%d', h)];
        
        save([ Name_complejos num2str(m) '.mat'],'complex_eigth')
        save([ Name_index num2str(m) '.mat'],'Index_cuad')
        
        %  Complex_eight_full{h}{m}=complex_eigth;
         %  Index_eight_full{h}{m}=  Index_cuad;
           
       clearvars -except  delaunay  h m  Name_complejos Name_index pathname pathname_index pathname1 pathname2
           
     %  clearvars -except  delaunay  Complex_eight_full Index_eight_full h m
 
       
    end
        clearvars -except  delaunay h  pathname pathname_index 
  end

end







