library(testthat)

context("Binomial Function")

test_that("bin_choose works as expected", {

  expect_error(bin_choose(2, 5))
  expect_equal(bin_choose(5, 2), 10)
  expect_length(bin_choose(5, 1:3), 3)
})

test_that("bin_probability works as expected", {

  expect_error(bin_probability(10, 2, 1))
  expect_type(bin_probability(2, 5, 0.5), 'double')
  expect_length(bin_probability(0:2, 5, 0.5), 3)
})

test_that("bin_distribution works as expected", {

  expect_error(bin_distribution(10, 1.1))
  expect_is(bin_distribution(10, 0.5), c("bindis", "data.frame"))
  expect_length(bin_distribution(10, 0.5), 2)
  expect_equal(round(bin_distribution(5, 0.5)[[2]][1], 3), 0.031)
})

test_that("bin_cumulative works as expected", {

  expect_error(bin_cumulative(10, 1.1))
  expect_is(bin_cumulative(10, 0.5), c("bincum", "data.frame"))
  expect_length(bin_cumulative(10, 0.5), 3)
  expect_equal(round(bin_cumulative(5, 0.5)[[3]][3], 1), 0.5)
})
