
make_stats_tab <- function(data) {
  
  data %>% 
    mutate(across(Longhorn:Wagyu, ~ .x - lag(.x), .names = '{.col}_gain')) %>% 
    rowwise() %>% 
    mutate(
      sd   = sd(c_across(Longhorn:Wagyu), na.rm = TRUE)
    ) %>% 
    ungroup() %>% 
    summarize(
      'Current Avg. Weight'                        = 
        across(Longhorn:Wagyu, max, na.rm = TRUE) %>% 
        unlist() %>% 
        mean(),
      'Avg. Std. Deviation Between Kitten Weights' = 
        mean(sd),
      'Avg. Gain per Feeding per Kitty'            =
        across(ends_with('_gain'), mean, na.rm = TRUE) %>% 
        unlist() %>% 
        mean(),
      'Avg. Gain per Day per Kitty'                =
        data %>% 
        group_by(day = floor_date(Timestamp, 'day')) %>% 
        summarize(across(Longhorn:Wagyu, ~ {
          max(.x, na.rm = TRUE) - min(.x, na.rm = TRUE)
        }), .groups = 'drop') %>% 
        ungroup() %>% 
        summarize(across(Longhorn:Wagyu, mean), .groups = 'drop') %>% 
        unlist() %>% 
        mean(),
      'Avg. Time Between Feedings'                 =
        mean(diff(Timestamp)) %>% 
        as.period() %>% 
        as.character() %>% 
        str_remove(' [:graph:]+S$'),
      'Expected Avg. Weight at 3 Years of Age'      =
        across(Longhorn:Wagyu, list(model = ~ { 
          linear_reg() %>% 
            set_engine('lm') %>% 
            fit(.x ~ Timestamp, data = data) %>% 
            predict(new_data = tibble(Timestamp = min(Timestamp) + years(3)))
        })) %>% 
        unlist() %>% 
        mean(),
      .groups = 'drop'
    ) %>% 
    mutate(across(c(1:4, 6), . %>% round(2) %>% scale_weights)) %>% 
    pivot_longer(everything(), names_to = 'Statistic', values_to = 'Value') %>% 
    kable()
  
}
