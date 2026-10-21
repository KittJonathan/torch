# Deep Learning and Scientific Computing with R torch
# https://skeydan.github.io/Deep-Learning-and-Scientific-Computing-with-R-torch/
# Chapter 3 - Tensors
# https://skeydan.github.io/Deep-Learning-and-Scientific-Computing-with-R-torch/tensors.html

# Packages ----

library(torch)
library(tidyverse)

# What's in a tensor? ----

t1 <- torch_tensor(1)  # 1 dim tensor
t1

# Access the tensor's properties

t1$dtype
t1$device
t1$shape

# Change some properties

t2 <- t1$to(dtype = torch_int())
t2$dtype

# Only applicable if you have a GPU

# t2 <- t1$to(device = "cuda")
# t2$device

# Turn this 1-D “vector tensor” into a 2-D “matrix tensor”

t3 <- t1$view(c(1, 1))
t3$shape

# Example in R
c(1)
matrix(1)

# Creating tensors ----

## Tensors from values ----

torch_tensor(1:5)

# set the data type
torch_tensor(1:5, dtype = torch_float())

# Pass in a matrix
torch_tensor(matrix(1:9, ncol = 3))
torch_tensor(matrix(1:9, ncol = 3, byrow = TRUE))

# Pass in an array
torch_tensor(array(1:24, dim = c(4, 3, 2)))
array(1:24, dim = c(4, 3, 2))

## Tensors from specifications ----

# standard-normally distributed value
torch_randn(3, 3)

# values that are uniformly distributed between zero and one
torch_rand(3, 3)

# tensor of all zeros
torch_zeros(2, 5)

# tensor of all ones
torch_ones(2, 2)

# identity matrix
torch_eye(n = 5)

# diagonal matrix
torch_diag(c(1, 2, 3))

## Tensors from datasets ----

# time series of quarterly earnings per Johnson & Johnson share
JohnsonJohnson

torch_tensor(JohnsonJohnson)

unclass(JohnsonJohnson)

# Trunk thickness of Orange trees
glimpse(Orange)

# Turn dataset into a tensor
torch_tensor(Orange)

# Can torch handle factors?
f <- factor(c("a", "b", "c"), ordered = TRUE)
f
torch_tensor(f)

orange_ <- Orange |> 
  # extract the underlying levels
  mutate(Tree = as.numeric(Tree)) |> 
  # convert to matrix
  as.matrix()

orange_

torch_tensor(orange_) |> 
  print(n = 7)

# Operations on tensors ----

## Addition ----

t1 <- torch_tensor(c(1, 2))
t2 <- torch_tensor(c(3, 4))

t1
t2

torch_add(t1, t2)
t1$add(t2)

# Modify the object in place:
t1$add_(t2)
t1

## Dot product ----

t1 <- torch_tensor(1:3)
t2 <- torch_tensor(4:6)

t1$dot(t2)
t1$t()$dot(t2)

t3 <- torch_tensor(matrix(1:12, ncol = 3, byrow = TRUE))

t1
t3

t3$matmul(t1)

t1
t2
torch_multiply(t1, t2)

## Summary operations ----

m <- outer(1:3, 1:6)
m

sum(m)
apply(m, 1, sum)
apply(m, 2, sum)

# Tensor - overall sum
t <- torch_outer(torch_tensor(1:3), torch_tensor(1:6))
t
t$sum()

# Row sum
t$sum(dim = 1)

# Column sum
t$sum(dim = 2)

t <- torch_randn(4, 3, 2)
t

t$mean(dim = c(1, 2))

t$mean(dim = 2)

# Accessing parts of a tensor ----

t <- torch_tensor(matrix(1:9, ncol = 3, byrow = TRUE))
t

# 1st row of a 2-D tensor
t[1, ]

# drop dimensionality
t[1, , drop = FALSE]

# Slicing
t <- torch_rand(3, 3, 3)
t
t[1:2, 2:3, c(1, 3)]

# Access the last element 
t <- torch_tensor(matrix(1:4, ncol = 2, byrow = TRUE))
t
t[-1, -1]

# Every second column between columns 1 and 8
t <- torch_tensor(matrix(1:20, ncol = 10, byrow = TRUE))
t
t[ , 1:8:2]

# Index into the 1st dimension 
t1 <- torch_randn(2, 2)
t2 <- torch_randn(2, 2, 2)
t3 <- torch_randn(2, 2, 2, 2)

t1
t1[1, ..]

t2
t2[1, ..]

t3
t3[1, ..]

# Reshaping tensors ----

t <- torch_zeros(24)
print(t, n = 3)

# Reshape to a wide matrix
t2 <- t$view(c(2, 12))
t2

# Both tensors store their data in the same location
t$storage()$data_ptr()
t2$storage()$data_ptr()

# 3.5.1 Zero-copy reshaping vs. reshaping with copy