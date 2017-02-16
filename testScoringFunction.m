
% These values sometimes reach a solution but not always.  In all
% situations, it eventually flips out.  
% UPDATE... Just tried these values again and it flipped out immediately
% for the first two tries but then stayed stable once it found a solution.
% Perhaps I should try to find a way to disturb the balance a couple of
% times after it balances?
score = scoringFunction02([3.975 4.85 10.1 3.084375]) 

%K = [1.437500 3.296875 8.625000 1.507690];   %3.455000 	1.437500 3.296875 8.625000 1.507690
%K = [1 3 8 2];
%K = [5.000000	8.000000	10.000000	6.000000];
%K = [3.975 4.85 10.1 3.084375];              
%K = [1.5457 2.7166 11.9112 2.4923];              % Gets is upright quickly but only slowly drifts back
%K = [4 5 10 3];

% these values are really good but it is getting a high score. 114.52
%score = scoringFunction02([1 3 8 2]) 
   