install:
	Rscript -e "renv::restore()"

Analysis: table figures Indicator_Report.html

table: \
	outputs/table_1a.rds \
	outputs/table_1b.rds 

outputs/table_1a.rds: code/table/table_1a.R data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv
	Rscript code/table/table_1a.R
	
outputs/table_1b.rds: code/table/table_1b.R data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv
	Rscript code/table/table_1b.R

subproject1/output/scatter.png: subproject1/code/02_make_scatter.R data/data_clean.rds
	Rscript subproject1/code/02_make_scatter.R


figures: \
	"outputs/figure_1a.png" \
	"outputs/figure_1b.png" \
	"outputs/figure_1c.png"

"outputs/figure_1a.png" "outputs/figure_1b.png" "outputs/figure_1c.png": code/figure/figure_1.R data/Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv
	Rscript code/figure/figure_1.R

Indicator_Report.html: render_report.R \
	Indicator_Report.Rmd
	Rscript render_report.R

clean:
	rm outputs/*.rds && \
	rm output/*.png && \
	rm Indicator_Report.html

.PHONY: Analysis table figures \
	outputs/table_1a.rds \
	outputs/table_1b.rds \
	outputs/figure_1a.png \
	outputs/figure_1b.png \
	outputs/figure_1c.png 

