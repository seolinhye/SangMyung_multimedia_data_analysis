function [imgBnew] = CFAinterpolationBnew(cfaB, imgGnew)
%
% cfa RGGB pattern

[row, col] = size(cfaB);
cfaB = double(cfaB);
imgGnew = double(imgGnew);
imgB = zeros(row, col);
imgBnew = zeros(row, col);

% RG -> even line
% GB -> odd line
% 0 0 0 0 0 0 0 
% 0 B 0 B 0 B 0
% 0 0 0 0 0 0 0
% 0 B 0 B 0 B 0

for i = 5:2:row-2
    for j = 5:2:col-2
        imgBnew(i-1,j-1) = cfaB(i-1,j-1); % R 성분 그대로 copy
        imgBnew(i-1,j) = (cfaB(i-1,j-1)+cfaB(i-1,j+1))/2 + (-imgGnew(i-1,j-1)+2*imgGnew(i-1,j)-imgGnew(i-1,j+1))/2;
        imgBnew(i,j-1) = (cfaB(i-1,j-1)+cfaB(i+1,j-1))/2 + (-imgGnew(i-1,j-1)+2*imgGnew(i,j-1)-imgGnew(i+1,j-1))/2;
        imgBnew(i,j) = BwithG(cfaB, imgGnew, i, j);
    end
end

imgBnew = uint8(imgBnew);

function [imgBG] = BwithG(cfaB, imgGnew, i, j)
%
%

DN = abs(-imgGnew(i-1,j-1)+2*imgGnew(i,j)-imgGnew(i+1,j+1)) + abs(cfaB(i-1,j-1)-cfaB(i+1,j+1));
DP = abs(-imgGnew(i-1,j+1)+2*imgGnew(i,j)-imgGnew(i+1,j-1)) + abs(cfaB(i-1,j+1)-cfaB(i+1,j-1));

if (DN>DP)
    imgBG = (cfaB(i-1,j+1)+cfaB(i+1,j-1))/2 + (-imgGnew(i-1,j+1)+2*imgGnew(i,j)-imgGnew(i+1,j-1))/2;
else
    imgBG = (cfaB(i-1,j-1)+cfaB(i+1,j+1))/2 + (-imgGnew(i-1,j-1)+2*imgGnew(i,j)-imgGnew(i+1,j+1))/2;
end



