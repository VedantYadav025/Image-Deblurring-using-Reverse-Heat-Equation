%Project: CS663
%IMAGE RESTORATION USING GEOMETRICALLY STABILIZED REVERSE HEAT
%EQUATION

%Reading the images from the files
%The original image is blurred with a Gaussian low pass filter with sigma =
%40
barbara = double(imread("/home/oddity/IITB/Sem5/CS 663/HW2/barbara256.png"));
barbara_blurry = mygaussianblur(barbara, 40);

imshow(barbara/255);
title('Original image');

imshow(barbara_blurry/255);
title('Blurred image');

%Implementing deblurring using the reverse heat equation
barbara_deblurred = myRHEdeblur(barbara_blurry);

imshow(barbara_deblurred/255);
title('Deblurred image');
imwrite("~/IITB",barbara_deblurred/255)

