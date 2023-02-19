function [imgF] = imgFilterFreqMsk(img, imgmsk)
% imgFilter ~ 이게 함수 이름 
% img, msk 입력, imgF 출력 (여러개의 출력 가능) 
% function 밑 function은 같은 파일 내에서만 사용이 가능, 외부에서는 첫번째 함수만 가능

[row, col, dep] = size(img); %3차원 data 가정
%imgF = img; %imgF 미리 준비하거나
imgF = zeros(row, col, dep); %아니면 미리 초기화 하는 경우도 있음 (속도 개선)

%mask는 분명 0~255 값일텐데 이를 normalization 해주어야 한다. 0~1 로 
imgmsk = double(imgmsk)/255; %mask의 최대값이 255인 경우에 해당

for k = 1:dep %흑백영상은 1번 컬러영상은 3번 돈다
    imgF(:,:,k) = imgFilterFreqMskGray(img(:,:,k), imgmsk);
end

%imgFilterFreqMskGray function (함수 내 서브함수)
function imgF = imgFilterFreqMskGray(img, msk)
%
%

%영상이 들어오면 푸리에 변환을 해준다. 
imgft = fft2(img); %2차원 data fft, imgft는 복소수 형태로 나온다.
% 양쪽 끝이 저주파임 fft를 하면 저-고 고-주로 해서 대칭되어 나옴 mask는 좌표축으로 보았을 때, 가운데를 저주파로 알텐데 그래서 오른쪽 데이터를 왼쪽 끝으로 shift 작업이 필요함
imgfts = fftshift(imgft); %spectrum이 mask와 동일하게 된다. 
imgtemp = imgfts.*msk; %주파수 영역에서의 filtering 한 것
imgtemp = ifftshift(imgtemp);
imgF = ifft2(imgtemp); 
%///// (l = 22~28) 주파수 영역에서의 filtering 과정



