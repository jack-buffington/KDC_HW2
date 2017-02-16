% this version eliminates the end condition that it get back to the home
% position.


fileID = fopen('bruteForce03.txt','w');




%% Run some episodes
N = 40;


C1 = 0;
C2 = 0;
C3 = 0;
C4 = 0;


while true
   fprintf('testing %f\t%f\t%f\t%f\n',C1,C2,C3,C4);
   score = scoringFunction03([C1 C2 C3 C4]); 

   if score < 10        
      fprintf(fileID,'%f\t%f\t%f\t%f\t%f\n',score,C1,C2,C3,C4);
   end
    
   C4 = C4 + 1;
   if C4 == 11;
      C4 = 0;
      C3 = C3 + 1;
      if C3 == 11;
         C3 = 0;
         C2 = C2 + 1;
         if C2 == 11;
            C2 = 0;
            C1 = C1 + 1;
            if C1 == 1  % I don't care about getting back to home for this one.
               break
            end
         end
      end
   end
end % of while loop
fclose(fileID);

