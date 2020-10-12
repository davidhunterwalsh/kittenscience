library(conflicted)
library(dotenv)
library(drake)
library(googledrive)
library(googlesheets4)
library(kableExtra)
library(knitr)
library(lubridate)
library(magrittr)
library(parsnip)
library(tidyverse)
library(rmarkdown)

tribble(
  ~ name,   ~ winner,
  'filter', 'dplyr',
  'lag',    'dplyr'
) %>% 
  pwalk(conflict_prefer, quiet = TRUE)
