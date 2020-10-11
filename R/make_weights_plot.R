make_weights_plot <- function(data) {
  
  # Define a pretty labeling function for weights in pounds and ounces
  weight_scale <- function(ounces) {
    pounds <- ounces %>% divide_by(16) %>% floor()
    ounces %<>% mod(16)
    str_glue('{pounds}lb{ounces}oz') %>% str_remove('0lb')
  }
  
  data %>% 
    pivot_longer(
      -Timestamp, 
      names_to       = 'Kitten',
      values_to      = 'Weight',
      values_drop_na = TRUE
    ) %>% 
    ggplot(aes(Timestamp, Weight)) %+%
    # Plot the datapoints
    geom_point(aes(color = Kitten)) %+%
    # Make the loess lines
    geom_smooth(aes(color = Kitten), method = 'loess', formula = 'y ~ x') %+%
    # Add the mean line
    stat_summary(fun = mean, geom = 'line', color = 'darkgray') %+%
    # Add some whitespace between the axis labels and the plot
    scale_x_datetime('\nTimestamp') %+%
    scale_y_continuous('Weight\n', labels = weight_scale) %+% 
    labs(
      title   = 'Kitten Weights',
      caption = 'Note: Gray line shows mean weights at feeding times'
    )
  
}