function [basin,theta0_vec,thetadot0_vec,xdot0_vec] = lqrBoA()
    theta0_vec = linspace(-90,90,13);
    thetadot0_vec = linspace(-30,30,7);
    xdot0_vec = linspace(-30,30,7);
    basin = zeros(size(theta0_vec,2),size(thetadot0_vec,2),size(xdot0_vec,2));
    
    for theta0_idx = 1:size(theta0_vec,2)
        for thetadot0_idx = 1:size(thetadot0_vec,2)
            for xdot0_idx = 1:size(xdot0_vec,2)
                x0 = 0;
                theta0 = theta0_vec(theta0_idx);
                thetadot0 = thetadot0_vec(thetadot0_idx);
                xdot0 = xdot0_vec(xdot0_idx);
                
                assignin('base','x0',x0);
                assignin('base','theta0',theta0);
                assignin('base','thetadot0',thetadot0);
                assignin('base','xdot0',xdot0);
                
                sim('cartPole_LQR.slx');
                
                final_ang = rad2deg(ang(end));
                final_anv = rad2deg(anv(end));
                final_pos = pos(end);
                final_vel = vel(end);
                if((abs(final_ang) <= deg2rad(5)) && (abs(final_anv) <= 1) && ...
                        (abs(final_pos) <= 1) && (abs(final_vel) <= 1))
                    basin(theta0_idx,thetadot0_idx,xdot0_idx) = 1;
                end
            end
        end
    end
end