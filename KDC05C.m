function KDC05B()
   K = [4 5 10 3];
   %K = [0 0 0 0];
   lb = [0 0 0 0];
   ub = [20 20 20 20];
   
   options = optimset('Display','iter','MaxFunEvals',1000000,'Algorithm','sqp');
   %bestSolution = cmaesJack01( 20, 0, [4 5 10 3], 100);
   %[answer,fval,exitflag]=fmincon(@criterion,p0,[],[],[],[],lb,ub,@constraints,options);

   %answer = fmincon(@scoringFunction,K,[],[],[],[],lb,ub,@constraints,options);
   answer = fmincon(@scoringFunction_fmincon,K,[],[],[],[],lb,ub,[],options);
   answer
end



function [c,ceq] = constraints(values)
% the values being passed are the K parameters
%     % Be at the target
%     global x_d;
%     eq_violations(1) = pos(1) - x_d(1);
%     eq_violations(2) = pos(2) - x_d(2);
%     eq_violations(3) = pos(3) - x_d(3);
   score = scoringFunction(values);
   
   if score == 1000
      c = 1;
   else
      c = 0;
   end
   
   
    ceq=[];
    

end