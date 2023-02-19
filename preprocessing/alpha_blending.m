%Alpha-Blending
clear;
clc; 

img0 = imread("baboon.png");
img1 = imread("lena.png");

alpha = (0:0.1:1);

Len = length(alpha);
%알파의 크기값을 개수로 가져온다.

%matlab은 1번지부터, index가 1부터 시작한다.
for n = 1:Len
    alp = alpha(n);
    img = (1-alp)*img0 + alp*img1;
    imshow(img);

end

%blending 기법은 영상뿐 아니라 음성에서도 이용
% 두 음악을 부드럽게 넘어가도록?
