# Deep Learning and Scientific Computing with R torch
# https://skeydan.github.io/Deep-Learning-and-Scientific-Computing-with-R-torch/
# Chapter 7  Modules
# https://skeydan.github.io/Deep-Learning-and-Scientific-Computing-with-R-torch/modules.html

# Packages ----

library(torch)

# Built-in nn_module()'s ----

l <- nn_linear(in_features = 5, out_features = 16)
l

l$weight
l$bias

# Apply the `l` module to input data
x <- torch_randn(50, 5)
output <- l(x)
output$size()

# Gradient computation
output$grad_fn

# calculate some “dummy” loss based on output, and call backward()
loss <- output$mean()
loss$backward()
l$weight$grad

# Building up a model ----

## Models as sequences of layers ----

mlp <- nn_sequential(
  nn_linear(10, 32),
  nn_relu(),
  nn_linear(32, 64),
  nn_relu(),
  nn_linear(64, 1)
)

mlp

# Apply the model to data
mlp(torch_randn(5, 10))

## Models with custom logic ----

my_linear <- nn_module(
  
  initialize = function(in_features, out_features) {
    self$w <- nn_parameter(torch_randn(
      in_features, out_features
    ))
    self$b <- nn_parameter(torch_zeros(out_features))
  },
  
  forward = function(input) {
    input$mm(self$w) + self$b
  }
)

l <- my_linear(7, 1)
l
