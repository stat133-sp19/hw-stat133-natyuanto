library(testthat)

context("Summary measures")

test_that("aux_mean works as expected", {

  expect_equal(aux_mean(10, 0.3), 3)
  expect_type(aux_mean(10, 0.5), 'double')
  expect_length(aux_mean(10, 0.01), 1)

})

test_that("aux_variance works as expected", {

  expect_equal(aux_variance(10, 0.3), 2.1)
  expect_type(aux_mean(10, 0.5), 'double')
  expect_length(aux_mean(10,0.01), 1)

})

test_that("aux_mode works as expected", {

  expect_equal(aux_mode(10, 0.3), 3)
  expect_type(aux_mode(10, 0.5), 'double')
  expect_length(aux_mode(10,0.01), 1)

})

test_that("aux_skewness works as expected", {

  expect_equal(round(aux_skewness(10, 0.3), 3), 0.276)
  expect_type(aux_skewness(10, 0.5), 'double')
  expect_length(aux_skewness(10,0.01), 1)
})

test_that("aux_kurtosis works as expected", {

  expect_equal(round(aux_kurtosis(10, 0.3), 3), -0.124)
  expect_type(aux_kurtosis(10, 0.5), 'double')
  expect_length(aux_kurtosis(10,0.01), 1)

})
