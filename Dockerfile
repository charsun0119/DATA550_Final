FROM rocker/r-ubuntu:22.04

RUN apt-get update && apt-get install -y \
    pandoc \
    libcurl4-openssl-dev \
    libxml2-dev \
    libx11-dev \
    libnode-dev \
    libssl-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /project
WORKDIR /project

RUN mkdir -p outputs

COPY code code
COPY Makefile .
COPY Indicator_Report.Rmd .    
COPY data data

COPY .Rprofile .
COPY renv.lock .
RUN mkdir -p renv
COPY renv/activate.R renv/
COPY renv/settings.json renv/

RUN Rscript -e "renv::restore(prompt=FALSE)"

RUN mkdir -p final_report 

CMD make && mv report.html final_report/

