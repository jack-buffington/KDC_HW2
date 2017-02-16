fileID = fopen('changing1000B.txt','r');

for I = 1:115
   data = textscan(fileID,'%f',4,'Delimiter','\t');
   temp(I,:) = data{1}';
end

% The above code loads all of the previously recorded good values into an
% array.