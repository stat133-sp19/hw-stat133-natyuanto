#' @title Binomial Choose
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n number of trials
#' @param k number of successes
#' @return number of combinations in which k successes can occur in n trials
#' @export
#' @examples
#'
#' bin_choose(n = 5, k = 2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)

bin_choose <- function(n,k) {
  if (any(k>n)) {
    stop("k cannot be greater than n")
  }
  choose = factorial(n)/(factorial(k)*factorial(n-k))
  return(choose)
}
