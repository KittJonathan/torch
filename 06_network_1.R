# Deep Learning and Scientific Computing with R torch
# https://skeydan.github.io/Deep-Learning-and-Scientific-Computing-with-R-torch/
# Chapter 6 - A neural network from scratch
# https://skeydan.github.io/Deep-Learning-and-Scientific-Computing-with-R-torch/network_1.html

# Packages ----

library(torch)
# library(tidyverse)

# Idea ----

# Input data: 100 observations, with 3 features each
x <- torch_randn(100, 3)
x$size()

# Per-feature coefficients
w <- torch_randn(3, 1, requires_grad = TRUE)

# Bias tensor
b <- torch_zeros(1, 1, requires_grad = TRUE)

# Get a 'prediction'
y <- x$matmul(w) + b
print(y, n = 10)

# Layers ----

# Layer with 8 units
w1 <- torch_randn(3, 8, requires_grad = TRUE)

# Bias layer
b1 <- torch_zeros(1, 8, requires_grad = TRUE)

w2 <- torch_randn(8, 1, requires_grad = TRUE)
b2 <- torch_randn(1, 1, requires_grad = TRUE)

# Activation functions ----

