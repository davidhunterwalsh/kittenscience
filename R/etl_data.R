etl_data <- function() {
  read_sheet('1Eo23GqsjOYIW0Y2bKzJBcmcPj0iXVqIsEzfDjPAALa8') %>% 
    rename(Poop = `Poop?`) %>% 
    mutate(across(Poop, list(
      Angus    = . %>% str_detect('A'),
      Brangus  = . %>% str_detect('B'),
      Longhorn = . %>% str_detect('L'),
      Wagyu    = . %>% str_detect('W')
    ))) %>% 
    select(-Poop)
}
