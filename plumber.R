
#* @get /mean
#* @json
normalMean <- function(n=100, string = 'I love Meggan!'){
  a = rep(string, n)
  as.vector(a)
}
