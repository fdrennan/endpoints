# plumber.R

#* @get /mean
normalMean <- function(n=100, string = 'I love Meggan!'){
  a = rep(string, n)
  as.vector(a)
}

#* @get /sum
addTwo <- function(a=10, b=10){
  as.numeric(a) + as.numeric(b)
}

#' Echo the parameter that was sent in
#' @param msg The message to echo back.
#' @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#' Plot out data from the iris dataset
#' @param spec If provided, filter the data to only this species (e.g. 'setosa')
#' @get /plot
#' @png
function(spec){
  myData <- iris
  title <- "All Species"
  
  # Filter if the species was specified
  if (!missing(spec)){
    title <- paste0("Only the '", spec, "' Species")
    myData <- subset(iris, Species == spec)
  }
  
  plot(myData$Sepal.Length, myData$Petal.Length,
       main=title, xlab="Sepal Length", ylab="Petal Length")
}

#' Plot out data from the iris dataset
#' @param days If provided, filter the data to only this species (e.g. 'setosa')
#' @get /weather
#' @jpeg (width=2^10 + 1)
function(days = 7){
  library(drentools)
  library(lubridate)
  
  weather <- 
    retrieve_data('focoWeather') %>% 
    as.data.frame()
  
  weather <- 
    weather %>% 
    select(temp, time) %>% 
    mutate(day = day(time)) %>% 
    filter(time > Sys.Date() - days)
  
  gg <- 
    ggplot(weather) +
    aes(x = time, y = temp, colour = as.factor(day)) +
    geom_line() +
    ggtitle(paste0('Ft. Collins Temp over paste', days, ' days.'))
  
  print(gg)
}
