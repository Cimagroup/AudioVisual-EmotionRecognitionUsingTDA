%% Construction of the Delaunay trinagulation in every video associated with th 24 persons
function Delaunay_base= delaunay_construction(pathdata) 

%pathdata='/EmotionalRecognition/Database/Speech/Actor_%d/Actor%d_%d.csv';
Delaunay_person= [];

for j=1:24
    
    for i=1:60
       matFileName = sprintf(pathdata,j,j, i);
       csv = readtable(matFileName); 
       %csv(89:size(csv,1),:)=[];
       csv(:,2:297)=[];
       
       csv(:,138:416)=[];
        %list_o_cols_to_delete = [2 3 7 8 13 15 19 20 24 25 29 31 35 36 40 41 45 47 ...
         %   51 52 56 57 61 63 67 68 72 73 77 79 83 84 88];
       %csv(list_o_cols_to_delete,:) = [];
       %obtener los puntos de la boca solamente
       %csv(:,29:69)=[];
       %csv(:,56:96)=[];
       
       for k=1:10:size(csv,1)
       Vector_y=(table2array(csv(k,70:137)))';
       %Vector_y = (table2array(csv(k,29:55)))';
       Vector_x=(table2array(csv(k,2:69)))';
       %Vector_x=(table2array(csv(k,2:28)))';
       point_cloud{k}=[Vector_x Vector_y];
       Delaunay_person{i,k}= delaunayTriangulation(point_cloud{k});
       end
       %Delaunay;
       %Delaunay_person{i,k}=Delaunay{k};
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
     




