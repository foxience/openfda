# The full tutorial can be found here: https://github.com/rOpenHealth/openfda

install.packages('devtools')
library(devtools)
devtools::install_github('ropenhealth/openfda')
library(openfda)

# Install mxnet for full-featured neural network modeling
install.packages('/home/mxnet/mxnet_0.7.tar.gz', repos = NULL, type="source")
library(mxnet)
