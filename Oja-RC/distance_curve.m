%% FORCE learning with Oja's plasticity

function [D, conv_num, distance_tran, distance_conv, fixed_point] = distance_curve(target, Out)

Th_d = 0.01;
conv_num = NaN;
distance_tran = NaN;
distance_conv = NaN;

K = size(target, 1);

[Idx, D] = knnsearch(target', Out');

L = length(D);
for i = 1:L
    if D(i)/sqrt(K) < Th_d
        conv_num = i;

        distance_tran = mean(D(1:i));
        distance_conv = mean(D(i+1:L));

        break
    end
end

LastOut = Out(1, L-99:L);
if abs(max(LastOut) - min(LastOut)) < Th_d
    fixed_point = 1;
else
    fixed_point = 0;
end

end