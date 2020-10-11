source('packages.R')

list.files('R', full.names = TRUE) %>% walk(source)

source('plan.R')

drake_config(
  the_plan,
  trigger    = trigger(condition = TRUE),
  lock_envir = FALSE
)
