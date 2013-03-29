function neighbor_list = neighbor2list(neighbor)

[m, n] = size(neighbor);

neighbor_list = zeros(n*(n-1)/2,2);
count = 1;

for i = 1:n
    for j = 1:m
        if i<neighbor(j,i)
            neighbor_list(count,:) = [i,neighbor(j,i)];
            count = count+1;
        end
    end
end