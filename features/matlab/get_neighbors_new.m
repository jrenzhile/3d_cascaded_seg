function  neighbors = get_neighbors_new(face)

nFace  = size(face,2);
neighbors = zeros(size(face));


for i=1:nFace
    count = 1;
    tmp_i = face(:,i);
    tmp_i = sort(tmp_i);
    for j= 1:nFace
        
        ii = 1;
        jj = 1;
        
        count_inters = 0;
        tmp_j = face(:,j);
        tmp_j = sort(tmp_j);
        while(ii<=3 && jj<=3)
            if(tmp_i(ii)==tmp_j(jj))
                 count_inters = count_inters+1;
                 ii=ii+1;
                 jj= jj+1;
            elseif(tmp_i(ii)>tmp_j(jj))
                    jj = jj+1;
            else
                ii = ii+1;
            end
        end
        if count_inters ==2
            neighbors(count,i)=j;
            count = count+1;
            if count>3
                break
            end
        end
 
    end
end
