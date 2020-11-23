function [f]=atmtest(boundary)
  f = zeros( 2, 6 );
for i =2:6
        % Boundary of cell processed is calculated
        bound_cell = boundary(:,i);
        bound_cell = boundary(  bound_cell > 0, i );
        if isempty( bound_cell )
            % If boundary of cell doesn't exist then boundaris of f and phi
            % is null
            f_borders=[];
        else
            % If boundary of cell exists then f and phi of boundary of cell
            % are calculated
            tmp = f(:, bound_cell);
            f_borders = compress( reshape( tmp, size(tmp,1) * size(tmp,2), 1 ) );
        end
        % If f(boundary of cell) is null (a new homology class is created)
        % then cell is added to homology: Hi=Hi-1+{cell i},
        % fi(cell-i)=cell-i, gi(cell i)=cell-i+phi i-1(boundary(cell i)),
        % phi i(cell i)=0
        if isempty( f_borders )
         f(:,i) = [i; zeros( size(f,1) - 1, 1 )];
        else
            % A homology class is destroyed
            % fi(cell i)=0
         f(:,i) = 0;
           
         % cell j exist in fi-1(boundary(cell i)) / j is maximum
         j_max = max(f_borders);

            
         % Exist x / cell j exist fi-1(x)
           fx = f(:,1:i-1);
           [~, X] = find(fx==j_max);
            % For all x / cell j exist fi-1(x)
            for x=X'
                % fi(x)=fi-1(x)+fi-1(boundary(cell i))
                tmp=compress( [f(:,x); f_borders] );
                if size(tmp,1) > size (f,1)
                    f(size(tmp,1),x) = 0;
                end
                f(:,x) = [tmp; zeros( size(f,1) - size(tmp,1), 1 )];
                
            end
            
   
        end
end
f=sparse(f);
end