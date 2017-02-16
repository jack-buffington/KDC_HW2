% use something like gradient descent to move towards the best solution. 
%need to use a known point that can go 60 seconds though.  



function KDC05B()
   %K = [4 5 10 3]; % arrives at 3.975000 4.850000 10.100000 3.084375
   %K = [5 6 9 2]; % arrives at a bad solution (I created these numbers randomly)
   K = [2.000000	4.000000	9.000000	2.000000]; % arrives at 1.755859 3.250000 7.972656 2.144531
   stepSize = 1;
   
   bestScore = scoringFunction02(K);
   
   lastK = K;
   
   
   % repeatedly go through the four variables and take a step in 
   % both directions and see how it scores. Change K as appropriate. 
   
   while stepSize  > .0001
      changedSomething = false;
      for I = 1:4
         % change the appropriate variable
         highK = K;
         lowK = K;
         highK(I) = highK(I) + stepSize;
         lowK(I) = lowK(I) - stepSize;
         
         
         highKscore = scoringFunction02(highK);
         lowKscore = scoringFunction02(lowK);
         
         if highKscore < bestScore
            bestScore = highKscore;
            K = highK;
            changedSomething = true;
         end
         
         if lowKscore < bestScore
            bestScore = lowKscore;
            K = lowK;
            changedSomething = true;
         end
         
      end % of iterating through all four variables
      
      if changedSomething == false
         stepSize = stepSize / 2;
      end
      fprintf('stepSize: %f\t %f %f %f %f\n',stepSize,K(1), K(2),K(3),K(4)); 
   end
   
   
   fprintf('Final K:  %f %f %f %f\n',K(1), K(2), K(3), K(4));
end
