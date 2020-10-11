#' @title A pretty markup function for weights in pounds and ounces

scale_weights <- function(ounces) {
  pounds <- ounces %>% divide_by(16) %>% floor()
  ounces %<>% mod(16)
  ounces <- if_else(pounds == 0, ounces, round(ounces))
  str_glue('{pounds}lb {ounces}oz') %>% str_remove('0lb')
}

