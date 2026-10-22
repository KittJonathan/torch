# Deep Learning and Scientific Computing with R torch
# https://skeydan.github.io/Deep-Learning-and-Scientific-Computing-with-R-torch/
# Chapter 5 - Function minimization with autograd
# https://skeydan.github.io/Deep-Learning-and-Scientific-Computing-with-R-torch/optim_1.html

# Packages ----

library(torch)
# library(tidyverse)

# An optimization classic ----

# Rosenbrock function: function of two variables, with minimum (1,1).

a <- 1
b <- 5

rosenbrock <- function(x) {
  x1 <- x[1]
  x2 <- x[2]
  (a - x1)^2 + b * (x2 - x1^2)^2
}

# Minimization from scratch ----

lr <- 0.01
num_iterations <- 1000
x <- torch_tensor(c(-1, 1), requires_grad = TRUE)

for (i in 1:num_iterations) {
  
  if (i %% 100 == 0) cat("Iteration: ", i, "\n")
  
  # call function, passing in current parameter value
  value <- rosenbrock(x)
  
  if (i %% 100 == 0) {
    cat("Value is: ", as.numeric(value), "\n")
  }
  
  # compute gradient of value w.r.t. parameter
  value$backward()
  
  if (i %% 100 == 0) {
    cat("Gradient is: ", as.matrix(x$grad), "\n")
  }
  
  # manually update parameter, subtracting a fraction
  # of the gradient
  with_no_grad({
    x$sub_(lr * x$grad)
    x$grad$zero_()
  })
  
  
}

x
