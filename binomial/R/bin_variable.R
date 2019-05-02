#' @title Binomial Random Variable
#' @description lists the number of trials and probability of success
#' @param trials number of trials
#' @param prob probability of success
#' @return data.frame with two classes: c("bindis", "data.frame")
#' @export
#' @examples
#'
#' bin_variable(trials = 10, p = 0.3)

bin_variable <- function(trials, prob){
  if(check_trials(trials) | check_prob(prob)){
    result <- list(trials, prob)
    class(result) <- c("binvar")
    names(result) <- c("trials", "prob")
    return(result)
  } else{
    stop()
  }
}

#' @export
print.binvar <- function(result) {
  cat('"Binomial Variable"',sep="\n")
  cat(sep="\n")
  cat("Parameters",sep="\n")
  cat("- number of trials: ")
  cat(result[["trials"]],sep="\n")
  cat("- prob of success : ")
  cat(result[["prob"]],sep="\n")
}

#' @export
summary.binvar <- function(result) {
  summ <- list(trials = result[["trials"]],
               prob = result[["prob"]],
               mean = aux_mean(result[["trials"]], result[["prob"]]),
               variance = aux_variance(result[["trials"]], result[["prob"]]),
               mode = aux_mode(result[["trials"]], result[["prob"]]),
               skewness = aux_skewness(result[["trials"]], result[["prob"]]),
               kurtosis = aux_kurtosis(result[["trials"]], result[["prob"]]))
  class(summ) <- "summary.binvar"
  summ
}

#' @export
print.summary.binvar <- function(result){
  cat('"Summary Binomial"\n\n')
  cat("Parameters\n")
  cat("- number of trials:", result$trials, "\n")
  cat("- prob of success:", result$prob, "\n\n")
  cat("Measures\n")
  cat("- mean\t  :", result$mean, "\n")
  cat("- variance:", result$variance, "\n")
  cat("- mode\t  :", result$mode, "\n")
  cat("- skewness:", result$skewness, "\n")
  cat("- kurtosis:", result$kurtosis, "\n")
}
