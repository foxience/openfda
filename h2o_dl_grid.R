library(h2o)
library(ggplot2)
library(tidyr)
library(dplyr)

h2o_instance <- h2o.init(ip = "127.0.0.1", port = 54321)
prostate <- h2o.importFile("https://s3.amazonaws.com/h2o-public-test-data/smalldata/wisc/wisc-diag-breast-cancer-shuffled.csv")
splits <- h2o.splitFrame(prostate, c(0.6, 0.2), seed=1234)

prostate.train <- splits[[1]]
prostate.validate <- splits[[2]]
prostate.test <- splits[[3]]

summary(prostate.train)
summary(prostate.validate)
summary(prostate.test)

y <- "diagnosis"
x <- setdiff(names(prostate.train), c("diagnosis", "id"))

hyper_params <- list(hidden=list(c(10), c(30), c(100),
                                 c(10, 10, 10),
                                 c(30, 30, 30),
                                 c(100, 100, 100)),
                     l1=c(1e-4, 1e-3, 1e-2),
                     l2=c(1e-4, 1e-3, 1e-2))
dl_grid <- h2o.grid("deeplearning",
                   grid_id = "dl_hidden_regularization_grid",
                   x = x, y = y,
                   training_frame = prostate.train,
                   validation_frame = prostate.validate,
                   distribution = "bernoulli",
                   activation = "Tanh",
                   loss = "CrossEntropy",
                   hyper_params = hyper_params,
                   sparse = TRUE,
                   epochs = 10000,
                   stopping_rounds = 3,
                   stopping_tolerance = 0.05,
                   stopping_metric = "misclassification",
                   seed = 1234)
# print out all prediction errors and run times of the models
dl_grid
# print out the Test MSE for all of the models
for (model_id in dl_grid@model_ids) {
  model <- h2o.getModel(model_id)
  print(model@parameters$hidden)
  print(sprintf("Regularization params: %f %f", model@parameters$l1, model@parameters$l2))
  mse <- h2o.mse(model, valid = TRUE)
  print(sprintf("Test set MSE: %f", mse))
}