% this script plots out 3D data as 2D slices
clear

X = 1;


fileID = fopen('bruteForce03B.txt','r');
try
   I = 1;
   while true
      data = textscan(fileID,'%f',5,'Delimiter','\t');
      
      temp(I,:) = data{1}';
      I = I+1;
   end

   
catch 
   disp('That''s all...');
end

numItems = I;

fclose(fileID);

figure()
grid on

% plot all of the rectangles that are on level 3
% for I = 1:numItems
%    if temp(I,3) == 3
%       X = temp(I,4);
%       Y = temp(I,5);
%       rectangle('Position',[X Y 1 1],'FaceColor',[.5 .5 .5],'EdgeColor','none');
%    end
% end


% for I = 1:numItems
%    if temp(I,3) == 3
%       X = temp(I,4);
%       Y = temp(I,5);
%       xx = [X X X+1 X+1];
%       yy = [Y Y+1 Y+1 Y];
%       zz = [3 3 3 3];
%       patch(xx,yy, zz,[.5 .5 .5]);
%    end
% end

for I = 1:numItems -1
      X = temp(I,4);
      Y = temp(I,5);
      Z = temp(I,3);
      xx = [X X X+1 X+1];
      yy = [Y Y+1 Y+1 Y];
      zz = [Z Z Z Z];
      cc = Z/10;
      patch(xx,yy, zz,[cc cc cc],'EdgeColor','none');
end