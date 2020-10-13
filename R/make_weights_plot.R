make_weights_plot <- function(data) {
  
  data %>% 
    pivot_longer(
      -c(Timestamp, contains('Poop')), 
      names_to       = 'Kitten',
      values_to      = 'Weight',
      values_drop_na = TRUE
    ) %>% 
    ggplot(aes(Timestamp, Weight)) %+%
    # Plot the datapoints
    geom_point(aes(color = Kitten)) %+%
    geom_rug(
      aes(Timestamp, y = 6, color = Kitten), 
      sides    = 'b',
      position = 'jitter',
      data     = 
        data %>% 
        pivot_longer(contains('Poop'), names_to = 'Kitten') %>% 
        mutate(across(Kitten, str_remove, 'Poop_')) %>% 
        filter(value)
    ) %+%
    # Make the loess lines
    geom_smooth(aes(color = Kitten), method = 'loess', formula = 'y ~ x') %+%
    # Add the mean line
    stat_summary(fun = mean, geom = 'line', color = 'darkgray') %+%
    # Add some whitespace between the axis labels and the plot
    scale_x_datetime('\nTimestamp') %+%
    scale_y_continuous('Weight\n', labels = scale_weights) %+% 
    labs(
      # title   = 'Kitten Weights',
      caption = 'Note: Gray line tracks mean weights at feeding times; rug indicates poops.'
    )
  
}