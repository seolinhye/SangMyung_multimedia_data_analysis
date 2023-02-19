function [imgRnew] = CFAinterpolationRnew(cfaR, imgGnew)
%
% cfa RGGB pattern

[row, col] = size(cfaR);
cfaR = double(cfaR);
imgGnew = double(imgGnew);
imgR = zeros(row,col);
imgRnew = zeros(row, col);

% RG -> even line
% GB -> odd line
% R 0 R 0 R 0 
% 0 0 0 0 0 0
% R 0 R 0 R 0 

for i = 4:2:row-2
    for j = 4:2:col-2
        imgRnew(i-1,j-1) = cfaR(i-1,j-1); % R 성분 그대로 copy
        imgRnew(i-1,j) = (cfaR(i-1,j-1)+cfaR(i-1,j+1))/2 + (-imgGnew(i-1,j-1)+2*imgGnew(i-1,j)-imgGnew(i-1,j+1))/2;
        imgRnew(i,j-1) = (cfaR(i-1,j-1)+cfaR(i+1,j-1))/2 + (-imgGnew(i-1,j-1)+2*imgGnew(i,j-1)-imgGnew(i+1,j-1))/2;
        imgRnew(i,j) = RwithG(cfaR, imgGnew, i, j);
    end
end

imgRnew = uint8(imgRnew);   

function [imgRG] = RwithG(cfaR, imgGnew, i, j)
%
%
DN = abs(-imgGnew(i-1,j-1)+2*imgGnew(i,j)-imgGnew(i+1,j+1)) + abs(cfaR(i-1,j-1)-cfaR(i+1,j+1));
DP = abs(-imgGnew(i-1,j+1)+2*imgGnew(i,j)-imgGnew(i+1,j-1)) + abs(cfaR(i-1,j+1)-cfaR(i+1,j-1));

if (DN>DP)
    imgRG = (cfaR(i-1,j+1)+cfaR(i+1,j-1))/2 + (-imgGnew(i-1,j+1)+2*imgGnew(i,j)-imgGnew(i+1,j-1))/2;
else
    imgRG = (cfaR(i-1,j-1)+cfaR(i+1,j+1))/2 + (-imgGnew(i-1,j-1)+2*imgGnew(i,j)-imgGnew(i+1,j+1))/2;
end



