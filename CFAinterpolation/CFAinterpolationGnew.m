function [imgGnew] = CFAinterpolationGnew(cfaG, cfaR, cfaB)
%
%

[row, col] = size(cfaG);
% 정확한 연산과 정보를 날리지 않기 위해 형변환 필요
cfaG = double(cfaG);
cfaR = double(cfaR);
cfaB = double(cfaB);
imgGnew = zeros(row, col);

% RG -> even line
% GB -> odd line
% 0 G 0 G 0 G
% G 0 G 0 G 0 
% 0 G 0 G 0 G
% G 0 G 0 G 0 의 pattern 반복

for i = 3:2:row-2
    for j = 3:2:col-2
        imgGnew(i,j) = GwithR(cfaR, cfaG, i, j);
        imgGnew(i,j+1) = cfaG(i,j+1);
        imgGnew(i+1,j) = cfaG(i+1,j);
        imgGnew(i+1,j+1) = GwithB(cfaB, cfaG, i+1, j+1);
    end
end

imgGnew = uint8(imgGnew);

function [imgGR] = GwithR(cfaR, cfaG, i, j) 
%
%

DH = abs(-cfaR(i,j-2)+2*cfaR(i,j)-cfaR(i,j+2)) + abs(cfaG(i,j-1)-cfaG(i,j+1));
DV = abs(-cfaR(i-2,j)+2*cfaR(i,j)-cfaR(i+2,j)) + abs(cfaG(i-1,j)-cfaG(i+1,j));

if (DH<DV)
    imgGR = (cfaG(i,j-1) + cfaG(i,j+1))/2 + (-cfaR(i,j-2)+2*cfaR(i,j)-cfaR(i,j+2))/4;
elseif (DV<DH)
    imgGR = (cfaG(i-1,j) + cfaG(i+1,j))/2 + (-cfaR(i-2,j)+2*cfaR(i,j)-cfaR(i+2,j))/4;
else
    imgGR = (cfaG(i-1,j) + cfaG(i,j-1) + cfaG(i,j+1) + cfaG(i+1,j))/4 + (-cfaR(i-2,j)-cfaR(i,j-2)+4*cfaR(i,j)-cfaR(i,j+2)-cfaR(i+2,j))/8;
end


function [imgGB] = GwithB(cfaB, cfaG, i, j)
%
%

DH = abs(-cfaB(i,j-2)+2*cfaB(i,j)-cfaB(i,j+2)) + abs(cfaG(i,j-1)-cfaG(i,j+1));
DV = abs(-cfaB(i-2,j)+2*cfaB(i,j)-cfaB(i+2,j)) + abs(cfaG(i-1,j)-cfaG(i+1,j));

if (DH<DV)
    imgGB = (cfaG(i,j-1) + cfaG(i,j+1))/2 + (-cfaB(i,j-2)+2*cfaB(i,j)-cfaB(i,j+2))/4;
elseif (DV<DH)
    imgGB = (cfaG(i-1,j) + cfaG(i+1,j))/2 + (-cfaB(i-2,j)+2*cfaB(i,j)-cfaB(i+2,j))/4;
else
    imgGB = (cfaG(i-1,j) + cfaG(i,j-1) + cfaG(i,j+1) + cfaG(i+1,j))/4 + (-cfaB(i-2,j)-cfaB(i,j-2)+4*cfaB(i,j)-cfaB(i,j+2)-cfaB(i+2,j))/8;
end





  