function score = scoringFunction(values)
   % this was providing some bad scores.  After checking out what was going
   % on, I saw that sometimes when I ran a simulation it would work out OK
   % and other times it would flip out almost immediately.   Sometimes it
   % would become balanced and then after being stationary for a bit, it
   % would go biserk.   To fix this, the next version will perform the same
   % test initially but then continue to run the simulation for 10 seconds
   % past finding a good balance.  If it failed, it would report a high
   % score.  Also, if it passed, then it would rerun it a couple of times
   % to verify that it indeed was a good solution.  


   %##############################################################################
   %####################### Test at .15 * pi initial tilt ########################
   %##############################################################################

   success = false;

   sim = odesim('KDC04_15.xml');                % initial angle is .25*pi
   sim.realtime();                                  % Slow down to realtime

   % Define sensors and actuators
   pos = sim.sensor('robot.base.position.y');       % Cart position sensor
   vel = sim.sensor('robot.base.velocity.y');       % Cart velocity sensor
   ang = sim.sensor('robot.polejoint.angle');       % Pole angle sensor
   anv = sim.sensor('robot.polejoint.anglerate');   % Pole angle rate sensor
   motor = sim.actuator('robot.motorjoint.torque'); % Wheel motor
   actuators = sim.actuate();                       % Get actuation vector


    endTime = 0;

    for t = 0:sim.step():60                       % go for up to 40 seconds
       endTime = t;
        try
        sensors = sim.sense();                   % Measure sensor values
        catch
           fprintf('things blew up!\n');
           break;
        end
        mysensors = sensors([pos vel ang anv]);  % Get the sensors we want
        if mysensors(3) > pi/2.5 || mysensors(3) < -pi/2.5
            break;
        elseif mysensors(3)^2 < .0000001 && ...
               mysensors(1)^2 < .00001 && ...
               mysensors(2)^2 < .00001 && ...
               t > 1
            success = true;
            break;

        end
        actuators(motor) = values * mysensors';       % Calculate actuation
        sim.actuate(actuators);                  % Run simulation step
    end

    if success == true
      score = endTime;  % if it succeeded in meeting the criteria then pass
                        % on the time it took 
    else                % if it failed then longer times are better
                        % make it so that if it failed immediately it
                        % doesn't have a good score.  
       score = 120 - endTime ;
    end
    sim.close() 
    %score
    fprintf('Score: %f \t%f %f %f %f\n',score,values(1),values(2),values(3),values(4));
    
    
    
end




