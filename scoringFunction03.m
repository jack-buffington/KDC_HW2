function score = scoringFunction03(values)
  % This version eliminates the scoring element that it must get back to X = 0

   
   maxMotor = 8;   
   
   maxMotorValue = 0;

   %##############################################################################
   %####################### Test at .15 * pi initial tilt ########################
   %##############################################################################

   success = false;
   reachedGoal = false;
   stopTime = 10000;

   sim = odesim('KDC04_15.xml');                % initial angle is .25*pi
   %sim.realtime();                                  % Slow down to realtime

   % Define sensors and actuators
   pos = sim.sensor('robot.base.position.y');       % Cart position sensor
   vel = sim.sensor('robot.base.velocity.y');       % Cart velocity sensor
   ang = sim.sensor('robot.polejoint.angle');       % Pole angle sensor
   anv = sim.sensor('robot.polejoint.anglerate');   % Pole angle rate sensor
   motor = sim.actuator('robot.motorjoint.torque'); % Wheel motor
   actuators = sim.actuate();                       % Get actuation vector


    endTime = 0;

    for t = 0:sim.step():60                       % go for up to 60 seconds
       endTime = t;
        try
        sensors = sim.sense();                   % Measure sensor values
        catch
           fprintf('things blew up!\n');
           break;
        end
        mysensors = sensors([pos vel ang anv]);  % Get the sensors we want
        if mysensors(3) > pi/2.5 || mysensors(3) < -pi/2.5  % if it tipped too far
            break;
            
        elseif reachedGoal == true  % 
           if t > stopTime  
              if  mysensors(3)^2 < .0000001 && ...  % angle of the bar
                  mysensors(2)^2 < .00001          % velocity of the cart
              success = true;
              end
              break; % stop either way after 10 seconds
           end
           
        elseif mysensors(3)^2 < .0000001 && ...
               mysensors(2)^2 < .00001 && ...
               t > .1  % changed from 1 to .1
            reachedGoal = true;
            fprintf('Reached the goal at %f seconds\n',t);
            stopTime = t + 10;
        end
        % TODO: Disturb the value given to the motor a couple of times
        % after it has achieved balance to see if I can make it unstable.
        % This is because some solutions can balance but are unstable in
        % some cases.  
        
        motorValue = values * mysensors';
        
        if abs(motorValue) > maxMotorValue
           maxMotorValue = abs(motorValue);
        end
        
        
        % limit the maximum value given to the motor
        if motorValue > maxMotor
           motorValue = maxMotor;
        elseif motorValue < -maxMotor
           motorValue = -maxMotor;
        end
           
         actuators(motor) = motorValue;       % Calculate actuation
        
        
        %actuators(motor) = values * mysensors';       % Calculate actuation
        sim.actuate(actuators);                  % Run simulation step
    end

    if success == true
      score = endTime - 10;  % if it succeeded in meeting the criteria then pass
                        % on the time it took 
    else                % if it failed then longer times are better
                        % make it so that if it failed immediately it
                        % doesn't have a good score.  
       score = 120 - endTime ;
    end
    sim.close() 
    %score
    fprintf('Score: %f \t%f %f %f %f\n',score,values(1),values(2),values(3),values(4));
    fprintf('Ended at %f seconds.\n',t);
    fprintf('Maximum MotorValue: %f\n',maxMotorValue);
    
end




