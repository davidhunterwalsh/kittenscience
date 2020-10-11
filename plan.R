the_plan <- drake_plan(

  data        = read_sheet('1Eo23GqsjOYIW0Y2bKzJBcmcPj0iXVqIsEzfDjPAALa8'),
  
  plot        = make_weights_plot(data),
  
  plot_jpeg   = ggsave(file_out('img/Kitten_Weights.jpeg'), plot, jpeg()),
  
  make_readme = render(
      input         = knitr_in("doc/readme.Rmd"),
      output_format = 'md_document',
      output_file   = file_out("readme.md"),
      output_dir    = '.'
    )
  
)
