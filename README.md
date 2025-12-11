# DATA550 Final Project Yijing Sun
## Project Description: Indicators of Anxiety or Depression Based on Reported Frequency of Symptoms During Last 7 Days
The Household Pulse Survey, conducted by the National Center for Health Statistics (NCHS) partnered with the Census Bureau, is a 20-minute online survey designed to rapidly and efficiently reflect how emergent social and economic issues impacted households across the country. This data set is a part of the survey that primarily focused on the national and the state level mental health trends under the COVID-19 pandemic from 2020 to 2024, based on validate screening questions following the two-item Patient Health Questionnaire (PHQ-2) and the two-item Generalized Anxiety Disorder (GAD-2) scale. Information on symptoms over the last 7 days, which was later expanded to a two-week reference period beginning July 2021. The data set also includes breakdown by demographic subgroups including age, sex, race/ethnicity, and educational attainment.

The report will be broken into several subprojects:
- The Codes for generating tables and figures (the numbers are not decided yet) can be found in 'code/table' and 'code/figure' folder, respectively
   1. code/table/: This folder contains all R scripts used to generate analytic tables for the report.
      a. table_1a.R: Summarizing national mean severity scores for anxiety, depression, and combined indicators across years
      b. table_1b.R: Summarizing the same severity indicators for the state of Georgia
   2. code/figure/: This folder contains all R scripts used to produce figures visualizing trends and demographic patterns.
      a. figure_1.R: Produces Figures 1A–1C, showing symptom severity across age groups for all indicators.
- The outputs will be saved in 'output' folder
   1. All intermediate outputs created by the project are saved here, including:
      a. .rds files for tables
      b. .png files for figures
- The original data (CDC Household Pulse Survey files) can be found in 'data' folder
- The final report can be found in 'final_report' folder generated
  
### Building the Project
This project uses a Makefile to ensure that all analyses and outputs can be reproduced. To build the entire project (including tables, regression outputs, and the final report), run "make" in R terminal; to remove previously generated files, run "make clean". 

To restore the package environment, at the root directory of the project run "make install" in R terminal, or renv::restore() in R console. 

### Building the Docker Image
The entire project environment is defined in the Dockerfile. Building the image ensures a fully reproducible environment for the analysis. 

To build the Docker image locally, at the root directory of the project run "docker build -t data550-report" in R terminal. 

### Creating the Report in Docker
Execute the Analysis and Create the Report

To create the report, at to the root directory of the project, run:

docker run --rm \
  -v "$(pwd)/report_output:/project/outputs" \
  data550-report:latest
  
in R terminal
