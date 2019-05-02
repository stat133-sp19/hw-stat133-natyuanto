#' @title Binomial Cumulative
#' @description calculates the probability distribution and the cumulative probabilities
#' @param trials number of trials
#' @param prob probability of success
#' @return a data frame with both the probability distribution and the cumulative probabilities: sucesses in the first column, probability in the second column, and cumulative in the third column
#' @export
#' @examples
#'
#' bin_cumulative(trials = 5, prob = 0.5)

bin_cumulative <- function(trials, prob){
  df <- bin_distribution(trials = trials, prob = prob)
  df$cumulative <- cumsum(df$probability)
  class(df) <- c("bincum", "data.frame")
  return(df)
}

#' @export
plot.bincum <- function(df) {
  plot(df$success,df$cumulative, type="o", xlab="successes", ylab="probability")
}
