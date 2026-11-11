%% FORCE learning with Oja's plasticity

%% distance curve

figure(7)
plot(0:1:Period, mean_distance, 'LineWidth', lwidth);

xlim([0 50])
xlabel('Time step')
ylabel('Mean distance')