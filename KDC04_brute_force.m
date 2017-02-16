
fileID = fopen('changing.txt','w');




%% Run some episodes
N = 40;


C1 = 4;
C2 = 5;
C3 = 10;
C4 = 3;


while true

% for C1 = 1:10
%    for C2 = 1:10
%       for C3 = 1:10
%          for C4 = 1:10
            success = false;

            %sim = odesim('KDC03.xml');                % Load configuration
            sim = odesim('KDC04_25.xml');                % Load configuration
            
            sim.realtime();                                  % Slow down to realtime

            % Define sensors and actuators
            pos = sim.sensor('robot.base.position.y');       % Cart position sensor
            vel = sim.sensor('robot.base.velocity.y');       % Cart velocity sensor
            ang = sim.sensor('robot.polejoint.angle');       % Pole angle sensor
            anv = sim.sensor('robot.polejoint.anglerate');   % Pole angle rate sensor
            motor = sim.actuator('robot.motorjoint.torque'); % Wheel motor
            actuators = sim.actuate();                       % Get actuation vector


            K = [C1 C2 C3 C4];

             % Control loop
             %try

             endTime = 0;

             for t = 0:sim.step():N                       % go for N seconds
                endTime = t;
                 try
                 sensors = sim.sense();                   % Measure sensor values
                 catch
                    fprintf('things blew up!\n');
                    break;
                 end
                 mysensors = sensors([pos vel ang anv]);  % Get the sensors we want
                 %fprintf('%f\t%f\n',mysensors(3), mysensors(1));
                 if mysensors(3) > pi/3 || mysensors(3) < -pi/3
                     %fprintf('bar went below horizontal at %f \n',t);

                     break;
                 elseif mysensors(3)^2 < .0000001 && ...
                        mysensors(1)^2 < .00001 && ...
                        mysensors(2)^2 < .00001 && ...
                        t > 1
                     success = true;
                     break;
                     
                 end
                 actuators(motor) = K * mysensors';       % Calculate actuation
                 %actuators(motor) = 0;
                 sim.actuate(actuators);                  % Run simulation step
             end
             fprintf('%f\t%f\t%f\t%f\t%f\n',endTime,C1,C2,C3,C4);
             %if endTime > 25
             if success == true
               fprintf(fileID,'%f\t%f\t%f\t%f\t%f\n',endTime,C1,C2,C3,C4);
             end
             sim.close()     
%    C4 = C4 + 1;
%    if C4 == 11;
%       C4 = 0;
%       C3 = C3 + 1;
%       if C3 == 11;
%          C3 = 0;
%          C2 = C2 + 1;
%          if C2 == 11;
%             C2 = 0;
%             C1 = C1 + 1;
%             if C1 == 11
%                break
%             end
%          end
%       end
%    end
end % of iterating through C1

fclose(fileID);

