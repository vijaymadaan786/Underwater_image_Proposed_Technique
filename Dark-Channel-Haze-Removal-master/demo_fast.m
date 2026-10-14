warning('off','all');

tic;
image = double(imread('5.jpg'))/255;

image = imresize(image, 0.4);

result = dehaze_fast(image, 0.95, 5);
toc;


figure;imshow(image);title("Image");
figure;imshow(result);title('Dehazed image');

PSNR = psnr(result, image);
disp(['PSNR: ', num2str(PSNR)]);

warning('on','all');