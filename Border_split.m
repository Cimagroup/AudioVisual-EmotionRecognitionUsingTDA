function [index_Cuad,  index_Ver, Barcode]= getBarcode(Filters_complex_eight_full)
for i=1:length(Filters_complex_eight_full)
    for j=1:length(Filters_complex_eight_full{i})
        for k=1:8
           [index_cuad, index_ver, barcode] = Incremental_Algorithm(Filters_complex_eight_full{i}{j}{k})
           
           index_cuad1{k}=index_cuad;
           index_ver1{k} =index_ver;
           barcode1{k}=barcode;
        end
        index_cuad2{j}=index_cuad1;
           index_ver2{j} =index_ver1;
           barcode2{j}=barcode1;
    end
    index_Cuad{j}=index_cuad2;
    index_Ver{j} =index_ver2;
    Barcode{j}=barcode2;
end