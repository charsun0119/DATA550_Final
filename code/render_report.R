library(rmarkdown)
library(here)

rmarkdown::render(
  input = "Indicator_Report.Rmd",
  output_file = "Indicator_Report.html",
  output_dir = "report",
  knit_root_dir = "."
)
