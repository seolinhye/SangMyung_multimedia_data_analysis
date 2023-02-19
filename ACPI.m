% image Lab 06 : 개선된 Demosaicking ( CFA interpolation )
% CFA - RG RG RG
%       GB GB GB
%clear;
%clc;

% image loading
fhead = 'lena';
fext = 'png';
filename = sprintf('%s.%s', fhead, fext);
img = imread(filename);

% 분할 작업 필요, R G B 따로 RGGB pattern으로 약속했기 때문에 어렵지 않게 분할 가능
% Split cfa into each spectrum
% R-plane sampling for RGGB CFA image
% R 0 R 0
% 0 0 0 0 , 2:2 downsample, R과 R 사이 2
pitch = [2, 2];
phpit = [0, 0]; % sample 되는 위치 값

imgD = SamplingDown(img(:,:,1), pitch, phpit);
cfaR = SamplingUp(imgD, pitch, phpit);
% B-plane sampling for RGGB CFA image
% 0 0 0 0
% 0 B 0 B
pitch = [2, 2];
phpit = [1, 1]; % sample 되는 위치 값 
imgD = SamplingDown(img(:,:,3), pitch, phpit);
cfaB = SamplingUp(imgD, pitch, phpit);

% G1-plane sampling for RGGB CFA image
% 0 G 0 G
% 0 0 0 0 
pitch = [2, 2];
phpit = [0, 1]; % sample 되는 위치 값 
imgD = SamplingDown(img(:,:,2), pitch, phpit);
cfaG1 = SamplingUp(imgD, pitch, phpit);
% G2-plane sampling for RGGB CFA image
% 0 0 0 0
% G 0 G 0
pitch = [2, 2];
phpit = [1, 0]; % sample 되는 위치 값 
imgD = SamplingDown(img(:,:,2), pitch, phpit);
cfaG2 = SamplingUp(imgD, pitch, phpit);
% or 나 +로 G-plane 합친다
cfaG = cfaG1 + cfaG2;

figure('Name', 'cfaRGB');
imshow([cfaR, cfaG, cfaB]);
% G가 sample이 2배 많으므로 선명도가 높은 이미지가 보임

% 최종적으로 CFA data라는 것은 RGB를 하나로 합친 것
cfa = cfaR + cfaG + cfaB;
figure('Name', 'cfa'); 
imshow(cfa);

% Linear image interpolation for R/G/B component
imgGnew = CFAinterpolationGnew(cfaG, cfaR, cfaB);
imgRnew = CFAinterpolationRnew(cfaR, imgGnew);
imgBnew = CFAinterpolationBnew(cfaB, imgGnew);

figure('Name', 'cfaIRGB'); 
imshow([imgRnew, imgGnew, imgBnew]);

% Comparison (원본과의 차이)
imgRe = img;
imgRe(:,:,1) = imgRnew;
imgRe(:,:,2) = imgGnew;
imgRe(:,:,3) = imgBnew;

% visual comparison
figure('Name', 'Comparison'); 
imshow([img, imgRe]); 

% objective comparison PSNR or SSIM
cutsize = [3, 3];
imgRe = CutBoundary(imgRe, cutsize);
img = CutBoundary(img, cutsize);
pval = psnr(imgRe, img, 255);
sval = ssim(imgRe, img); % correlation과 유사
txt = sprintf('PSNR = %4.2fdB, SSIM = %4.3f', pval, sval);
disp(txt);
