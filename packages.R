library(conflicted)
library(dotenv)
library(drake)
library(googledrive)
library(googlesheets4)
library(hablar)
library(kableExtra)
library(knitr)
library(lubridate)
library(magrittr)
library(parsnip)
library(slider)
library(tidyverse)
library(rmarkdown)

tribble(
  ~ name,   ~ winner,
  'filter', 'dplyr',
  'lag',    'dplyr'
) %>% 
  pwalk(conflict_prefer, quiet = TRUE)
