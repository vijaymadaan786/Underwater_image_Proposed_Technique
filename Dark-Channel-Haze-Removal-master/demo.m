warning('off','all');

tic;
image = double(imread('4.jpg'))/255;

image = imresize(image, 0.5);

result = dehaze(image, 0.95, 15);
toc;

figure;imshow(image);title("Image");
figure;imshow(result);title('Dehazed image');

PSNR = psnr(result, image);   % both are double in [0,1]
disp(['PSNR: ', num2str(PSNR)]);



warning('on','all');