% Blurs the image using a low-pass Gaussian filter
function blurred_image = mygaussianblur(image, sigma)

%Padding the image
H = size(image, 1);
W = size(image, 2);
image_padded = padarray(image, [H/2,W/2], 0);

%Applying Fourier Transform
fim = fftshift(fft2(image_padded));

%Applying gaussian filter with sigma = 40
filter = mygaussianfilter(sigma, H, W);
fimfiltered = fim.*filter;

%Applying Inverse Fourier Transform
blurred_image_padded = real(ifft2(ifftshift(fimfiltered)));
blurred_image = blurred_image_padded(H/2:3*H/2, W/2:3*W/2);
end

