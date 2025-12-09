library(rmarkdown)

rmarkdown::render(
  input = here::here("Indicator_Report.Rmd"),
  output_file = "Indicator_Report.html",
  output_dir = here::here("report"),
  knit_root_dir = here::here()
)
