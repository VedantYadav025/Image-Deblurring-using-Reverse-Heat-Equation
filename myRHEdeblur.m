% Implements the deblurring using Reverse Heat Equation(RHE)
function deblurred_image = myRHEdeblur(blurred_image)
%Implementing deblurring using the reverse heat equation

H = size(blurred_image, 1);
W = size(blurred_image, 2);
I = blurred_image; %Image that will change over iterations

%Constant parameters as mentioned in paper
c = 0.2;
beta = 0.02;
threshold = 0.3;

pixels_reached_threshold = zeros(H-2,W-2); %array indicating which pixels reached threshold

while pixels_reached_threshold ~= ones(H-2,W-2)

    I_new = zeros(H,W);

    for i = 2:1:H-1
        for j = 2:1:W-1 %WE donot consider the boundary 
                        %as the intensity doesn't update due to 0 gradient
            %Computing the lapclacian
            %Directional derivaitves
            I_x = I(i+1,j) - I(i,j);
            I_y = I(i,j+1) - I(i,j);
    
            I_xx = I(i+1,j) + I(i-1,j) - 2*I(i,j);
            I_yy = I(i+1,j) + I(i-1,j) - 2*I(i,j);
            I_xy = I(i+1,j+1) + I(i,j) - I(i+1,j) - I(i,j+1);
    
            %Checking the stopping criterion
            k = (I_xx*I_x^2 - 2*I_xy*I_x*I_y + I_yy*I_y^2)/(I_x^2 + I_y^2)^(3/2);
            if k > threshold
                pixels_reached_threshold(i-1,j-1) = 1;
            end

            if pixels_reached_threshold(i-1,j-1) == 0
                %Diffusion along the normal and tangent to edges
                I_nn = (I_xx*I_x^2 + 2*I_xy*I_x*I_y + I_yy*I_y^2)/(I_x^2 + I_y^2);
                I_tt = (I_xx*I_x^2 - 2*I_xy*I_x*I_y + I_yy*I_y^2)/(I_x^2 + I_y^2);
         
                Laplacian = I_nn + I_tt;
        
                %Updating the image pixel
                I_new(i,j) = I(i,j) - c*Laplacian + beta*I_nn;
            end
    
        end
    end
    
    I = I_new;

end

deblurred_image = I;

end

