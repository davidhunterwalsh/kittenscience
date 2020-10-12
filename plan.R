the_plan <- drake_plan(

  data        = target(
    trigger = trigger(condition = TRUE),
    etl_data()
  ),
  
  plot        = target(
    trigger = trigger(change = data),
    make_weights_plot(data)
  ),
  
  plot_jpeg   = ggsave(file_out('img/Kitten_Weights.jpeg'), plot, jpeg()),
  
  stats_tab   = make_stats_tab(data),
  
  make_readme = render(
      input         = knitr_in("doc/readme.Rmd"),
      output_format = 'md_document',
      output_file   = file_out("readme.md"),
      output_dir    = '.'
    )
  
)
