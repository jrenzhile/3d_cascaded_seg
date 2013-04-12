function g = sigmoid(z)

% g = sigmoid(z) computes the sigmoid of z. (z can be a matrix,
% vector or scalar).

g = 1./(1+exp(-z));

end
