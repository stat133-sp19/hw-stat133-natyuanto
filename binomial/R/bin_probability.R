#' @title Binomial Probability
#' @description calculates probability of getting a certain number successes in the number of desired trials
#' @param success number of successes
#' @param trials number of trials
#' @param prob probability of success
#' @return probability of getting the number of successes specified in the number of desired trials
#' @export
#' @examples
#'
#' # probability of getting 2 successes in 5 trials
#  # (assuming prob of success = 0.5)
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#'
#' # probabilities of getting 2 or less successes in 5 trials
#  # (assuming prob of success = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#'
#' # 55 heads in 100 tosses of a loaded coin with 45% chance of heads
#' bin_probability(success = 55, trials = 100, prob = 0.45)

bin_probability <- function(success, trials, prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)

  probability = bin_choose(trials,success) * prob^(success) * (1-prob)^(trials-success)
  return(probability)
}
