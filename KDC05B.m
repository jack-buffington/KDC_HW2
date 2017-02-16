function KDC05B()
   K = [4 5 10 3];
   
   options = optimset('Display','iter','MaxFunEvals',1000000,'Algorithm','sqp');
   %bestSolution = cmaesJack01( 20, 0, [4 5 10 3], 100);
   %[answer,fval,exitflag]=fmincon(@criterion,p0,[],[],[],[],lb,ub,@constraints,options);

   answer = fmincon(@scoringFunction,K,[],[]);
   answer
end

function score = scoringFunction(values)

    % creates a score to evaluate how things are going
   score = values(1)^2 + values(2)^2 + values(3)^2 + values(4)^2;
end


% function [ineq_violations,eq_violations] = constraints(p)
% 
%     % Be at the target
%     global x_d;
%     eq_violations(1) = pos(1) - x_d(1);
%     eq_violations(2) = pos(2) - x_d(2);
%     eq_violations(3) = pos(3) - x_d(3);
% 
%     ineq_violations=[];
%     
% 
% end