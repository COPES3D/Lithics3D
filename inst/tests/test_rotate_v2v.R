context("Rotate vector onto vector")

test_that("rotate_v2v output", {
  # X axis:
  x <- data.frame(x = c(0, 1), y = c(0, 0), z = c(0, 0))

  # Test point to rotate:
  pt1 <- data.frame(x = c(2, -1), y = c(2, -1), z = c(2, -1))

  test_v <- list()
  test_v[["0"]] <- list(v = data.frame(x = c(1, 4), y = c(1, 1), z = c(1, 1)),
                     out = data.frame(x = c(1, -2), y = c(1, -2), z = c(1, -2)))
  test_v[["90"]] <- list(v = data.frame(x = c(1, 1), y = c(1, 2), z = c(1, 1)),
                     out = data.frame(x = c(1, -2), y = c(-1, 2), z = c(1, -2)))
  test_v[["180"]] <- list(v = data.frame(x = c(1, -1), y = c(1, 1), z = c(1, 1)),
                     out = data.frame(x = c(-1, 2), y = c(-1, 2), z = c(-1, 2)))
  test_v[["270"]] <- list(v = data.frame(x = c(1, 1), y = c(1, -1), z = c(1, 1)),
                     out = data.frame(x = c(-1, 2), y = c(1, -2), z = c(1, -2)))
  test_v[["90z"]] <- list(v = data.frame(x = c(1, 1), y = c(1, 1), z = c(1, 4)),
                     out = data.frame(x = c(1, -2), y = c(1, -2), z = c(-1, 2)))

  for (i in names(test_v)){
    res <- rotate_v2v(test_v[[i]]$v, x, pt1)
    expect_that(res$coords, equals(matrix(unlist(test_v[[i]]$out),
                                           nrow = nrow(test_v[[i]]$out))))

    expect_that(names(res), equals(c("coords", "l")))
    expect_that(as.vector(res$l[1, ]), equals(c(0, 0, 0)))
    expect_that(round(as.vector(res$l[2, 2:3]), 10), equals(c(0, 0)))
    expect_that(dist(res$l)[1], equals(dist(test_v[[i]]$v)[1]))
    }

  # Test bad input:
  t.df <- data.frame(x = c(1, 2, 3, 3, 7),
                     y = c(0.5, 1, 1.5, 2, 2.5),
                     z = c(0.5, 1, 1.5, 2, 2.5))
  extra_col <-  c(1, 1, 1, 1, 1)

  # Input handling:
  expect_error(rotate_v2v(t.df[1, ], x, t.df))
  expect_error(rotate_v2v(t.df[1:2, 1:2], x, t.df))
  expect_error(rotate_v2v(cbind(t.df[1:2, ], extra_col[1:2]), x, t.df))

  # Input data is at least 3D (>3D OK as documented):
  expect_error(rotate_v2v(t.df[1:2, ], x, t.df[, 1:2]))

  # Special condition (point l1 input):
  expect_error(rotate_v2v(t.df[c(1, 1), ], x, t.df))

  aa <- rotate_v2v(t.df[c(1, 5), ], x, t.df)
  expect_that(names(aa), equals(c("coords", "l")))
  expect_that(as.vector(aa$l[1, ]), equals(c(0, 0, 0)))
  expect_that(round(as.vector(aa$l[2, ]), 5), equals(c(6.63325, 0, 0)))
})
