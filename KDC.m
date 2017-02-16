

%% Initialization
sim = odesim('KDC.xml');                % Load configuration
sim.realtime();                                  % Slow down to realtime

%% Define sensors and actuators
pos = sim.sensor('robot.base.position.y');       % Cart position sensor
vel = sim.sensor('robot.base.velocity.y');       % Cart velocity sensor
ang = sim.sensor('robot.polejoint.angle');       % Pole angle sensor
anv = sim.sensor('robot.polejoint.anglerate');   % Pole angle rate sensor
%motor = sim.actuator('robot.motorjoint.torque'); % Wheel motor
actuators = sim.actuate();                       % Get actuation vector
%bodies = sim.

%% Control vector
K = [10 4 20 1];                                 % Sub-optimal

%% Run some episodes
for s = 1:10
    % Control loop
    for t = 0:sim.step():2                       % Simulation loop (6s)
        sensors = sim.sense();                   % Measure sensor values
        mysensors = sensors([pos vel ang anv])  % Get the sensors we want
        %actuators(motor) = K * mysensors';       % Calculate actuation
        sim.actuate(actuators);                  % Run simulation step

    end
    sim.reset()                                  % Reset to initial cond.
end

%% Clean up
sim.close()                                      % Destroy simulation
