%This function obtain 8 border simplicial complexes filtered,
%from 4 view directions, 2 by each direction. 
function filters = filtrations(complex)

    pts_central=[];
    n=size(complex.pts,1);
    %n= max(complex.cuad(:,4))
    for i=1:162
      pts_central(i,:) = sum(complex.pts(complex.cuad(i,:),:))/4;
    end
    
    maxP = max(max(abs(complex.pts))) + 10000;
    
   %**********sort triangles*******************    
 
    [X,indX] = sortrows(pts_central); %ordenanado los puntso por el los elementos de la primer columna
    
    listPtsY(:,1) = pts_central(:,2); %invertir el orden de las x e y
    listPtsY(:,2) = pts_central(:,1);
   
    
    [X,indX] = sortrows(pts_central);
    [Y,indY] = sortrows(listPtsY);

     PtsDistXY = arrayfun(@(x,y) (abs(x+y)), pts_central(:,1),pts_central(:,2));
     
     tem = PtsDistXY;
     tem(:,2:3) = pts_central;
     [XY,indXY] = sortrows(tem);
     
     PtsDistYX = arrayfun(@(x,y)  (abs(x-y + maxP)/sqrt(2)), pts_central(:,1),pts_central(:,2));
     
     tem = PtsDistYX;
     tem(:,2:3) = pts_central;
     [YX,indYX] = sortrows(tem);
     
      
     complejoX = complex.cuad(indX,:);
       subcomplex = complejoX; %invierte orden
       ind = [size(subcomplex,1):-1:1];
       subcomplex = subcomplex(ind,:);
     complejoX_inv = subcomplex;
     
     complejoY = complex.cuad(indY,:);
       subcomplex = complejoY; %invierte orden
       ind = [size(subcomplex,1):-1:1];
       subcomplex = subcomplex(ind,:);
     complejoY_inv = subcomplex;
     
     complejoXY = complex.cuad(indXY,:);
       subcomplex = complejoXY; %invierte orden
       ind = [size(subcomplex,1):-1:1];
       subcomplex = subcomplex(ind,:);
     complejoXY_inv = subcomplex;
     
     complejoYX = complex.cuad(indYX,:);
       subcomplex = complejoYX; %invierte orden
       ind = [size(subcomplex,1):-1:1];
       subcomplex = subcomplex(ind,:);
     complejoYX_inv = subcomplex;
     
     filters.complejoX = unique(complejoX,'rows','stable');
     filters.complejoY = unique(complejoY,'rows','stable');
     filters.complejoXY = unique(complejoXY,'rows','stable');
     filters.complejoYX = unique(complejoYX,'rows','stable');
     
     filters.complejoX_inv = unique(complejoX_inv,'rows','stable');
     filters.complejoY_inv = unique(complejoY_inv,'rows','stable');
     filters.complejoXY_inv = unique(complejoXY_inv,'rows','stable');
     filters.complejoYX_inv = unique(complejoYX_inv,'rows','stable');
end