# Deep Learning and Scientific Computing with R torch
# https://skeydan.github.io/Deep-Learning-and-Scientific-Computing-with-R-torch/
# Chapter 4 - Autograd
# https://skeydan.github.io/Deep-Learning-and-Scientific-Computing-with-R-torch/autograd.html

# Packages ----

library(torch)
# library(tidyverse)

# Automatic differentiation with torch autograd ----

x1 <- torch_tensor(2, requires_grad = TRUE)
x2 <- torch_tensor(2, requires_grad = TRUE)

x1
x2

x3 <- x1$square()
x5 <- x3 * 0.2

x4 <- x2$square()
x6 <- x4 * 0.2

x7 <- x5 + x6 - 5
x7

x7$requires_grad

# Determine how x7 depends on x1 and x2
x7$backward()

x1$grad
x2$grad

x3$grad

x3 <- x1$square()
x3$retain_grad()

x5 <- x3 * 0.2
x5$retain_grad()

x4 <- x2$square()
x4$retain_grad()

x6 <- x4 * 0.2
x6$retain_grad()

x7 <- x5 + x6 - 5
x7$backward()

x3$grad
x4$grad
x5$grad
x6$grad

x3$grad_fn
x4$grad_fn
x5$grad_fn
x6$grad_fn
