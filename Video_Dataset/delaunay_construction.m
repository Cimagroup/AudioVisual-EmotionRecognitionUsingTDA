%% Construction of the Delaunay trinagulation in every video associated with th 24 persons
function Delaunay_base= delaunay_construction(pathdata) 

%pathdata='/EmotionalRecognition/Database/Speech/Actor_%d/Actor%d_%d.csv'
Delaunay_person= [];

for j=1:24
    
    for i=1:60
       matFileName = sprintf(pathdata,j,j, i);
       csv = readtable(matFileName); 
       %csv(89:size(csv,1),:)=[];
       csv(:,2:297)=[];
       
       csv(:,138:416)=[];
  
       
       for k=1:10:size(csv,1)
       Vector_y=(table2array(csv(k,70:137)))';
       %Vector_y = (table2array(csv(k,29:55)))';
       Vector_x=(table2array(csv(k,2:69)))';
       %Vector_x=(table2array(csv(k,2:28)))';
       point_cloud{k}=[Vector_x Vector_y];
       Delaunay_person{i,k}= delaunayTriangulation(point_cloud{k});
       end
 
    end
       Delaunay_base{j}=Delaunay_person;
end
Delaunay_base;


for i=1:24
    for j=1:60
        if size(Delaunay_base{i}{j}.ConnectivityList,1)>=109
          list= Delaunay_base{i}{j}.ConnectivityList;
           list(110:end,:)=[];
            Delaunay_base{i}{j}=triangulation(list,Delaunay_base{i}{j}.Points);
        end
    end
end

Delaunay_base;

end
     




