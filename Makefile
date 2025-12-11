all: install table figures report

.PHONY: install
install:
  Rscript -e "renv::restore(prompt = FALSE)"

table: outputs/table_1a.rds outputs/table_1b.rds

outputs/table_1a.rds: code/table/table_1a.R
	Rscript code/table/table_1a.R

outputs/table_1b.rds: code/table/table_1b.R
	Rscript code/table/table_1b.R

figures: outputs/figure_1a.png outputs/figure_1b.png outputs/figure_1c.png

outputs/figure_1a.png: code/figure/figure_1.R outputs/table_1a.rds
	Rscript code/figure/figure_1.R

outputs/figure_1b.png: code/figure/figure_1.R outputs/table_1b.rds
	Rscript code/figure/figure_1.R

outputs/figure_1c.png: code/figure/figure_1.R outputs/table_1a.rds outputs/table_1b.rds
	Rscript code/figure/figure_1.R

Indicator_Report.html: code/render_report.R Indicator_Report.Rmd figures table
	Rscript code/render_report.R

report: Indicator_Report.html


docker-build:
	docker build -t data550-report .
	
docker-run:
	docker run --rm -v "$$(pwd)/final_report":/project/final_report data550-final:latest

.PHONY: clean
clean:
	rm -f outputs/*.rds
	rm -f outputs/*.png
	rm -f final_report/Indicator_Report.html
	rm -rf final_report

