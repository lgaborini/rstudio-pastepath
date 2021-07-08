# allow clipboard access while testing non-interactively
withr::local_envvar(CLIPR_ALLOW = TRUE)

write_clipboard <- function(x) {
   clipr::write_clip(x)
   Sys.sleep(0.05)
}

test_that("retrieve_path works", {

   write_clipboard(" ")

   write_clipboard("c:\\")
   expect_equal(retrieve_path(wrap_quotes = FALSE), "c:/")

   write_clipboard("c:\\test\\")
   expect_equal(retrieve_path(wrap_quotes = FALSE), "c:/test/")

   write_clipboard("relative/")
   expect_equal(retrieve_path(wrap_quotes = FALSE), "relative/")

   write_clipboard("relative spaces/")
   expect_equal(retrieve_path(wrap_quotes = FALSE), "relative spaces/")

   write_clipboard("relative spaces\\")
   expect_equal(retrieve_path(wrap_quotes = FALSE), "relative spaces/")
})


test_that("retrieve_path adds quotes if not present", {

   write_clipboard(" ")

   write_clipboard('"c:\\"')
   expect_equal(retrieve_path(wrap_quotes = TRUE), '"c:/"')

   write_clipboard("c:\\test\\")
   expect_equal(retrieve_path(wrap_quotes = TRUE), '"c:/test/"')

   write_clipboard("relative/")
   expect_equal(retrieve_path(wrap_quotes = TRUE), '"relative/"')

   write_clipboard("relative spaces/")
   expect_equal(retrieve_path(wrap_quotes = TRUE), '"relative spaces/"')

   write_clipboard("relative spaces\\")
   expect_equal(retrieve_path(wrap_quotes = TRUE), '"relative spaces/"')
})

test_that("retrieve_path detects double quotes", {

   write_clipboard(" ")

   write_clipboard('"c:\\"')
   expect_equal(retrieve_path(wrap_quotes = TRUE), '"c:/"')

   write_clipboard("c:\\test\\")
   expect_equal(retrieve_path(wrap_quotes = TRUE), '"c:/test/"')

   write_clipboard('"relative/"')
   expect_equal(retrieve_path(wrap_quotes = TRUE), '"relative/"')

   write_clipboard('"relative spaces/"')
   expect_equal(retrieve_path(wrap_quotes = TRUE), '"relative spaces/"')

   write_clipboard('"relative spaces\\"')
   expect_equal(retrieve_path(wrap_quotes = TRUE), '"relative spaces/"')
})

test_that("retrieve_path detects single quotes", {

   write_clipboard(" ")

   write_clipboard("'c:\\'")
   expect_equal(retrieve_path(wrap_quotes = TRUE), "'c:/'")

   write_clipboard("'c:\\test\\'")
   expect_equal(retrieve_path(wrap_quotes = TRUE), "'c:/test/'")

   write_clipboard("'relative\\'")
   expect_equal(retrieve_path(wrap_quotes = TRUE), "'relative/'")

   write_clipboard("'relative spaces/'")
   expect_equal(retrieve_path(wrap_quotes = TRUE), "'relative spaces/'")

   write_clipboard("'relative spaces\\'")
   expect_equal(retrieve_path(wrap_quotes = TRUE), "'relative spaces/'")
})


