function [state, i, overshoot, compute_spiral_done, stay] = state_machine(curr_state, overshoot, compute_spiral_done, stay, grad_norm, i)
    
    state = curr_state;
    switch curr_state
        % Global strategy - AGD
        case 0
            % Check for overshoot
            if overshoot
                state = 1;
                i = i-1;
            end
            overshoot = 0;
        % Local strategy - BB
        case 1
            % Check for stop
            if grad_norm < 10^-4
                state = 2;
            end
        case 2
            if compute_spiral_done
                state = 3;
                i = i-1;
            end
            compute_spiral_done = 0;
        case 3
            % Check if next maximum found
            if stay == 0
                state = 0;
            end
            stay = 1;
        otherwise
            state = 0;
    end
end