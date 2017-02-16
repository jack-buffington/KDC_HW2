%POLEBALANCER ODE simulation of the cart-pole task
%   This script shows a cart balancing a pole.
%
%   Author: Wouter Caarls <w.caarls@tudelft.nl>

%% Initialization
sim = odesim('KDC03.xml');                % Load configuration
sim.realtime();                                  % Slow down to realtime

%% Define sensors and actuators
pos = sim.sensor('robot.base.position.y');       % Cart position sensor
vel = sim.sensor('robot.base.velocity.y');       % Cart velocity sensor
ang = sim.sensor('robot.polejoint.angle');       % Pole angle sensor
anv = sim.sensor('robot.polejoint.anglerate');   % Pole angle rate sensor
motor = sim.actuator('robot.motorjoint.torque'); % Wheel motor
actuators = sim.actuate();                       % Get actuation vector

%% Control vector
K = [1 3 6 2];                                  % 1 2 5 1 works
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

%% Run some episodes
N = 6;
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
