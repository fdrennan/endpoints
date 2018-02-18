# plumber.R
library(drentools)
library(tidyverse)
library(lubridate)

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

#' Generate a friendly error
#' @get /friendly
function(res){
  msg <- "Your request did not include a required parameter."
  res$status <- 400 # Bad request
  list(error=jsonlite::unbox(msg))
}


#' Plot out data from the iris dataset
#' @param days If provided, filter the data to only this species (e.g. 'setosa')
#' @get /weather
#' @jpeg (width=2^10 + 1)
weather = function(days = 7){

  days = as.numeric(days)
  if(days > 30) {
    
    days = 30
  }
  # rollbar.attached()

  
  
  weather <- 
    drentools::retrieve_data('focoWeather') %>% 
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
    ggtitle(paste0('Ft. Collins Temp over past ', days, ' days.'))
  
  print(gg)
}

#' @get /hello
#' @html
function(){
  paste0("<html><h1>hello world</h1></html>")
}

#' @get /type/<id>
function(id){
  list(
    id = id,
    type = typeof(id)
  )
}

users <- data.frame(
  uid=c(12,13),
  username=c("kim", "john")
)

#' Lookup a user
#' @get /users/<id>
function(id){
  subset(users, uid==id)
}

#' @get /food
search <- function(q="", pretty=0){
  paste0("The q parameter is '", q, "'. ",
         "The pretty parameter is '", pretty, "'.")
}

#' @get /scrape
scrape <- function(link, table=1){
  table = as.numeric(table)
  site <- rvest::html(link)
  site <- rvest::html_table(site, fill=TRUE)
  site[[table]]
}
