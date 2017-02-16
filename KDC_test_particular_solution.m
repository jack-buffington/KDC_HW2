

%% Initialization
sim = odesim('KDC03.xml');                % random tilt
%sim = odesim('KDC04_15.xml');               
sim.realtime();                                  % Slow down to realtime

%% Define sensors and actuators
pos = sim.sensor('robot.base.position.y');       % Cart position sensor
vel = sim.sensor('robot.base.velocity.y');       % Cart velocity sensor
ang = sim.sensor('robot.polejoint.angle');       % Pole angle sensor
anv = sim.sensor('robot.polejoint.anglerate');   % Pole angle rate sensor
motor = sim.actuator('robot.motorjoint.torque'); % Wheel motor
actuators = sim.actuate();                       % Get actuation vector

%% Control vector



%K = [1.437500 3.296875 8.625000 1.507690];   %3.455000 	1.437500 3.296875 8.625000 1.507690
%K = [1 3 8 2];
K = [3 4 10 3];
%K = [3.975 4.85 10.1 3.084375];              
%K = [1.5457 2.7166 11.9112 2.4923];              % Gets is upright quickly but only slowly drifts back
%K = [4 5 10 3];



                                                % 1 2 5 1 works
                                                % 1 3 6 2 works a lot better
                                                
                                                % * first term brings it back
                                                % to start position
                                                % * second term gives it an
                                                % extra kick if it starts
                                                % going too fast
                                                % * third term is the main
                                                % one.  It moves the cart
                                                % in the direction that arm
                                                % is falling.
                                                % * fourth term looks at
                                                % how quickly the arm is
                                                % falling and gives it an
                                                % extra kick if starts
                                                % moving faster.  

%score = scoringFunction02(K)
                                                
% Run some episodes
N = 7;
for s = 1:100
    % Control loop

       for t = 0:sim.step():N                       % go for N seconds
           sensors = sim.sense();                   % Measure sensor values
           mysensors = sensors([pos vel ang anv]);  % Get the sensors we want

           actuators(motor) = K * mysensors';       % Calculate actuation
           %actuators(motor) = 0;
           sim.actuate(actuators);                  % Run simulation step
       end
    sim.reset()                                  % Reset to initial cond.
end

%% Clean up
sim.close()                                      % Destroy simulation
