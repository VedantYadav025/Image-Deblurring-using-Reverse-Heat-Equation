% Creates the gaussian filter for a given sigma
function filter = mygaussianfilter(sigma, H, W)

filter = zeros(2*H, 2*W);
for i = 1:1:2*H
    for j = 1:1:2*W
        u = i-H;
        v = j-W;
        filter(i, j) = exp(-(u^2 + v^2)/(2*sigma^2));
    end
end
end

