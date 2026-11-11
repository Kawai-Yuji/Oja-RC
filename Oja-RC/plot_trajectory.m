%% FORCE learning with Oja's plasticity

if strcmp(taskname, '2d')
    figure(8)
    for m = 1:L
        plot([initial_Pos(1, m) Out_test_m(1, :, m)], [initial_Pos(2, m) Out_test_m(2, :, m)], 'LineWidth', lwidth)
        hold on
        plot(initial_Pos(1, m), initial_Pos(2, m), 'x', 'MarkerSize', markersize)
    end
    xlim([-1.1 1.1]);
    ylim([-1.1 1.1]);
    xlabel('Output y1')
    ylabel('Output y2')
    hold off

elseif strcmp(taskname, '3d')
    figure(8)
    for m = 1:L
        if initial_Pos(3, m) == 0
            plot([initial_Pos(1, m) Out_test_m(1, :, m)], [initial_Pos(2, m) Out_test_m(2, :, m)], 'LineWidth', lwidth)
            hold on
            plot(initial_Pos(1, m), initial_Pos(2, m), 'x', 'MarkerSize', markersize)
        end
    end
    xlim([-1.1 1.1]);
    ylim([-1.1 1.1]);
    xlabel('Output y1')
    ylabel('Output y2')
    hold off

    figure(9)
    for m = 1:L
        if initial_Pos(1, m) == 0
            plot([initial_Pos(2, m) Out_test_m(2, :, m)], [initial_Pos(3, m) Out_test_m(3, :, m)], 'LineWidth', lwidth)
            hold on
            plot(initial_Pos(2, m), initial_Pos(3, m), 'x', 'MarkerSize', markersize)
        end
    end
    xlim([-1.4 1.4]);
    ylim([-1.4 1.4]);
    xlabel('Output y2')
    ylabel('Output y3')
    hold off
end