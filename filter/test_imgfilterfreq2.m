%image filtering ing frequency domain

fname = 'baboon.png';
img = imread(fname);
fnamemsk = 'imgcir.png';
imgmsk = imread(fnamemsk);

figure(1); imshow(img);
figure(2); imshow(imgmsk);

imgF = imgFilterFreqMsk(img, imgmsk);

figure(3); imshow(uint8(imgF));

%시험은 21일 목요일 4시 G519실 시험범위는 비디오컨텐츠까지 영상올라온 거   