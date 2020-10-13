make_weights_plot <- function(data) {
  
  data %>% 
    rowwise() %>% 
    mutate(avg_weight = mean_(c_across(Longhorn:Wagyu))) %>% 
    ungroup() %>% 
    mutate(rolling_avg = avg_weight %>% slide_dbl(mean_, .before = 3)) %>% 
    pivot_longer(
      Longhorn:Wagyu, 
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
    geom_line(
      aes(y = rolling_avg),
      color    = 'darkgray'
    ) %+%
    # Add some whitespace between the axis labels and the plot
    scale_x_datetime('\nTimestamp') %+%
    scale_y_continuous('Weight\n', labels = scale_weights) %+% 
    labs(
      # title   = 'Kitten Weights',
      caption = 'Note: Gray line is 3-feeding rolling average weight; rug indicates poops.'
    )
  
}