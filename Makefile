all: install table figures Indicator_Report.html report

.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"

table: outputs/table_1a.rds outputs/table_1b.rds

outputs/table_1a.rds: code/table/table_1a.R data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv
	Rscript --vanilla -e "source('renv/activate.R'); library(here); setwd(here::here()); source('code/table/table_1a.R')"

outputs/table_1b.rds: code/table/table_1b.R data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv
	Rscript --vanilla -e "source('renv/activate.R'); library(here); setwd(here::here()); source('code/table/table_1b.R')"

figures: outputs/figure_1a.png outputs/figure_1b.png outputs/figure_1c.png

outputs/figure_1a.png outputs/figure_1b.png outputs/figure_1c.png: code/figure/figure_1.R data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv
	Rscript --vanilla -e "source('renv/activate.R'); library(here); setwd(here::here()); source('code/figure/figure_1.R')"

Indicator_Report.html: code/render_report.R Indicator_Report.Rmd
	mkdir -p report
	Rscript --vanilla -e "source('renv/activate.R'); setwd('/project'); source('code/render_report.R')"

report: Indicator_Report.html
	mkdir -p report

.PHONY: clean
clean:
	rm -f outputs/*.rds
	rm -f outputs/*.png
	rm -f Indicator_Report.html
	rm -rf report
