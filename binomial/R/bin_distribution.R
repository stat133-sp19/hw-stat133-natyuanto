#' @title Binomial Distribution
#' @description calculate the probabilities about the number of successes in a fixed number of random trials performed under identical conditions
#' @param trials number of trials
#' @param prob probability of success
#' @return data.frame with two classes: c("bindis", "data.frame")
#' @export
#' @examples
#'
#' bin_distribution(trials = 5, prob = 0.5)

bin_distribution <- function(trials,prob) {
  x <- bin_probability(0:trials, trials, prob)
  p <- data.frame(success = 0:trials, probability = x)
  class(p) <- c("bindis","data.frame")
  return(p)
}

#' @export
plot.bindis <- function(p) {
  barplot(p$probability, xlab="successes", ylab="probability", names.arg=p$success, main = "Binomial Probability Distribution")
}
