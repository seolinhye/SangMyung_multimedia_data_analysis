%image filtering
fname = 'lena.png';
img = imread(fname);
imshow(img);

%filter coeff. h
h = [ 1 2 3 4 5 4 3 2 1]; %크기가 9인 data, 1-D filter
%h는 matrix여야 함 영상이 matrix니까 그런데, 벡터인 경우도 있다.

%h의 sum을 1로 만들어주는 작업을 해야한다. 
h = h/sum(h); %dccomponent를 1로 만들어주는 과정

%1차원과 2차원으로 하려면 h를 matrix로 만들어주어야 한다.
hh = h'*h; % 2-D filter coeff
%h(:)*h는 무조건 column 벡터로 고정해준다. 이렇게 해도 된다. h는 row 벡터임 또는 h(:)*h(:)' 어찌 되었건 column x row 되도록

%hh의 sum이 1인지 확인 sum(hh(:)) = 1 이 나와야 한다
%영상의 밝기 정보는 유지시켜주도록 sum이 1이 나오도록 하는 작업을 하는 것임

%convolution을 이용한 filtering
%imgfil = conv2(img,hh); img가 3차원이라 서로의 차원이 맞지 않아서 불가 R,G,B 따로 하던가 imfilter사용
imgfil = imfilter(img,hh);

figure(2);
imshow(imgfil); %뿌옇게 바뀜 - > 고주파를 날렸다

%conv를 이용해서 하는 filtering 작업
imgR = double(img(:,:,1));
imgRfil = conv2(imgR,hh);
%conv operation이 사이즈를 키움 520x520으로 (512+9-1), boundary들이 까맣게 나옴
% 자르는 작업이 필요하다 테두리를, imgRfil(4:4+511, .. 잘라야 한다.
imgRfil = imgRfil(4:511+4,4:511+4);
figure(3); imshow(uing8(imgRfil));
%boundary extension이 발생하는데 이를 또 처리해주는 작업이 필요하다. 알아서 해보기..
%imgG = double(img(:,:,3));

