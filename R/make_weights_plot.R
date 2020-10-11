make_weights_plot <- function(data) {
  
  weight_scale <- function(ounces) {

    pounds <- ounces %>% divide_by(16) %>% floor()
    
    ounces %<>% mod(16)
    
    str_glue('{pounds}lb{ounces}oz') %>% str_remove('0lb')
    
  }
  
  round_datetime_limits <- function(default_limits) {
    default_limits %>% 
      modify_at(1, floor_date, 'days') %>% 
      modify_at(2, ceiling_date, 'days')
  }
  
  data %>% 
    pivot_longer(
      -Timestamp, 
      names_to       = 'Kitten',
      values_to      = 'Weight',
      values_drop_na = TRUE
    ) %>% 
    ggplot(aes(Timestamp, Weight)) %+%
    geom_point(aes(color = Kitten)) %+%
    geom_smooth(aes(color = Kitten), method = 'loess', formula = 'y ~ x') %+%
    stat_summary(fun = mean, geom = 'line', color = 'darkgray') %+%
    scale_x_datetime('\nTimestamp') %+%
    scale_y_continuous('Weight\n', labels = weight_scale) %+% 
    labs(
      title   = 'Kitten Weights',
      caption = 'Note: Gray line shows mean weights at feeding times'
    )
  
}