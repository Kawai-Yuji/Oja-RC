function cs = cosine_sim(V1, V2, d)
cs = zeros(d, d);
for i = 1:d
    for j = 1:d
        cs(i, j) = dot(V1(:, i), V2(:, j)) / (norm(V1(:, i)) * norm(V2(:, j)));
    end
end
cs = abs(cs);
end