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
dl <- h2o.deeplearning(x = x, y = y,
                      training_frame=prostate.train,
                      validation_frame=prostate.validate,
                      distribution="bernoulli",
                      activation="Tanh",
                      loss="CrossEntropy",
                      hidden=c(10,10,10),
                      l1=1e-3,
                      l2=1e-2,
                      sparse=TRUE,
                      epochs=10000,
                      stopping_rounds = 3,
                      stopping_tolerance = 0.05,
                      stopping_metric = "misclassification",
                      seed=1234)
predictions <- h2o.predict(dl, prostate.test)
head(predictions, 100)
h2o.performance(dl, prostate.test, valid=TRUE)
h2o.mse(dl, valid = TRUE)