library(testthat)

context("Checker Functions")

test_that("check_prob works as expected", {
  expect_true(check_prob(prob = 0.5))     #prob is a number between 0 and 1
  expect_error(check_prob(5))             #prob is invalid (not between 0 and 1)
  expect_length(check_prob(0.5), 1)       #prob is of length 1
})

test_that("check_trials works as expected", {
  expect_true(check_trials(7))            #trial is a non-negative  integer
  expect_error(check_trials(.4))          #trial is invalid (not an integer)
  expect_error(check_trials(-8))          #trial is invalid (not non-negative)
  expect_length(check_trials(5), 1)       #trial is of length 1
})

test_that("check_success works as expected", {
  expect_true(check_success(c(4), 8))     #success is less than or equal to trial
  expect_error(check_success(c(8), 4))    #success is invalid (success is not less than or equal to trial)
  expect_error(check_success(-8))         #success is invalid (not non-neagtive)
})
