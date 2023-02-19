function [imgD] = SamplingDown(img, pitch, phpit)
% pitch = [2, 3]; phpit = [0, 0];

% image down/up sampling

imgD = img(phpit(1)+1:pitch(1):end, phpit(2)+1:pitch(2):end, :);
