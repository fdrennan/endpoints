# plumber.R

#* @get /mean
normalMean <- function(n=100, string = 'I love Meggan!'){
  a = rep(string, n)
  as.vector(a)
}

