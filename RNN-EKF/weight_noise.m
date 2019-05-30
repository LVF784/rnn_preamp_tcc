%White gaussian noise
for i = 1:full_length
    noise(i,1) = (10e-04)*eta*randn(1);
end

W = W + noise;

%Noise covariance matrix
Q = noise*noise'; %complete