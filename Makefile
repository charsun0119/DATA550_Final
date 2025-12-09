all: install table figures Indicator_Report.html report

.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"

table: outputs/table_1a.rds outputs/table_1b.rds

outputs/table_1a.rds: code/table/table_1a.R data/Indicators_of_Anxiety_or_Depression_Based_On_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv
	Rscript code/table/table_1a.R

outputs/table_1b.rds: code/table/table_1b.R data/Indicators_of_Anxiety_or_Depression_Based_On_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv
	Rscript code/table/table_1b.R

figures: outputs/figure_1a.png outputs/figure_1b.png outputs/figure_1c.png

outputs/figure_1a.png outputs/figure_1b.png outputs/figure_1c.png: code/figure/figure_1.R data/Indicators_of_Anxiety_or_Depression_Based_On_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv
	Rscript code/figure/figure_1.R

subproject1/output/scatter.png: subproject1/code/02_make_scatter.R data/data_clean.rds
	Rscript subproject1/code/02_make_scatter.R

Indicator_Report.html: code/render_report.R Indicator_Report.Rmd
	Rscript code/render_report.R

report: Indicator_Report.html
	mkdir -p report

.PHONY: clean
clean:
	rm -f outputs/*.rds
	rm -f outputs/*.png
	rm -f Indicator_Report.html
	rm -rf report



