function [imgC] = CutBoundary(img, cutsize)
%
%

crow = cutsize(1);
ccol = cutsize(2);

imgC = img(1+crow:end-crow, 1+ccol:end-ccol, :);

